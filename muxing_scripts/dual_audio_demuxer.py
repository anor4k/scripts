import os
import subprocess

RAW_PATH = '/mnt/e/Torrent Downloads/Raw/[ReinForce] DanMachi II (BDRip 1920x1080 x264 FLAC)'
SUBS_PATH = RAW_PATH
DEST_PATH = '/mnt/c/Users/noel/Desktop/AoT'
MKVMERGE_PATH = 'mkvmerge'


def mux(video_source, sub_source, output):
    fonts = None
    subs = None
    chapters = None

    if os.path.isdir(sub_source):
        fonts = [os.path.join(sub_source, font) for font in os.listdir(sub_source) if font.endswith(('ttf', 'ttc', 'otf', 'otc'))]
        print(len(fonts), 'fonts to mux')
        subs = [os.path.join(sub_source, sub) for sub in os.listdir(sub_source) if sub.endswith(('utf', 'utf8', 'utf-8', 'idx', 'sub', 'srt', 'rt', 'ssa', 'ass', 'mks', 'vtt'))]
        print(len(subs), "subtitle tracks to mux")
        chapters = [os.path.join(sub_source, chapter) for chapter in os.listdir(sub_source) if chapter.endswith('xml')][0]

    args = [MKVMERGE_PATH]

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

    for sub in subs:
        args.append('--language')
        args.append('0:eng')
        args.append(sub)

    # print(*args)
    subprocess.run(args)


raws = [os.path.join(RAW_PATH, raw) for raw in os.listdir(RAW_PATH) if raw.endswith('.mkv')]
print('Raws:', raws)

sub_folders = [os.path.join(SUBS_PATH, folder) for folder in os.listdir(SUBS_PATH)]

if len(raws) != len(sub_folders):
    print('Different number of raw and subs')
    print(len(raws), 'raw files')
    print(raws)
    print(len(sub_folders), 'sub files')
    print(sub_folders)
    exit(1)

for (raw, sub) in zip(raws, sub_folders):
    output = DEST_PATH
    output = os.path.join(output, sub.split('/')[-1].strip('_Attachments') + '.mkv')
    mux(raw, sub, output)
