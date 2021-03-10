import os
import subprocess

RAW_PATH = '/mnt/e/Torrent Downloads/Raw/[VCB-Studio] K-ON!/[VCB-Studio] K-ON!! [Hi10p_1080p]/SPs/Ura-On'
SUBS_PATH = '/mnt/e/Torrent Downloads/Raw/K-ON/K-ON!! Ura-On!!'
DEST_PATH = '/mnt/c/Users/noel/Desktop/K-ON!! Ura-On!!'

MKVMERGE_PATH = 'mkvmerge'


def mux(video_source, sub_source, output):
    chapters = None
    subs = sub_source
    fonts_path = os.path.join(SUBS_PATH, 'fonts')
    fonts = [os.path.join(fonts_path, font) for font in os.listdir(fonts_path) if font.endswith(('ttf', 'ttc', 'otf', 'otc'))]

    args = [MKVMERGE_PATH]

    if chapters is not None:
        args.append('--chapters')
        args.append(chapters)

    for font in fonts:
        args.append('--attach-file')
        args.append(font)

    args.append('-o')
    args.append(output)

    if chapters is not None:
        args.append('--no-chapters')
    args.append('--no-subtitles')
    args.append(video_source)

    args.append('--language')
    args.append('0:eng')
    args.append(sub)

    print(*args)
    subprocess.run(args)


raws = [os.path.join(RAW_PATH, raw) for raw in os.listdir(RAW_PATH) if raw.endswith('.mkv')]
print('Raws:', raws)

subs = [os.path.join(SUBS_PATH, sub) for sub in os.listdir(SUBS_PATH) if sub.endswith(('.ass'))]

if len(raws) != len(subs):
    print('Different number of raw and subs')
    print(len(raws), 'raw files')
    print(raws)
    print(len(subs), 'sub files')
    print(subs)
    exit(1)

for (raw, sub) in zip(raws, subs):
    output = DEST_PATH
    output = os.path.join(output, raw.split('/')[-1] + '.mkv')
    mux(raw, sub, output)
