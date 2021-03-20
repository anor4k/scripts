#!/usr/bin/env python3

# identify volumes
# unzip files to temp folder
# parse chapters
# zip chapters
# mv to destination folder

import argparse
import logging
import shutil
import sys
from pathlib import Path
from zipfile import ZipFile
import re


class Mango():
    def __init__(self, out_path, temp_path='/tmp/neatomango'):
        self.logger = logging.getLogger(__name__)
        self.logger.addHandler(logging.NullHandler())
        self.chapters = {}
        try:
            self.tmp = Path(temp_path)
            self.tmp.mkdir(parents=True, exist_ok=True)
            self.logger.debug(f"Temporary directory: {self.tmp.absolute()}")
            self.out = Path(out_path)
            self.out.mkdir(parents=True, exist_ok=True)
            self.logger.debug(f"Output directory: {self.out.absolute()}")
        except OSError as e:
            self.logger.exception(f"Could not access {temp_path}. Make sure you have the correct permissions.")

    def extract(self, path):
        out = self.tmp / path.name.removesuffix(path.suffix)
        self.logger.debug(f"Extracting {path} to {out.absolute()}")
        with ZipFile(path, 'r') as z:
            z.extractall(out)
            pass
        return out

    def compress(self, files, out):
        self.logger.debug(f"Compressing {files} to {out}")
        with ZipFile(out, 'w') as z:
            for f in files:
                z.write(f, f.name)
                pass
        return out

    def read_files(self, path):
        self.logger.debug("Reading files...")
        extensions = ('.zip', '.rar', '.cbz', '.cbr')
        try:
            files = filter(lambda filepath: filepath.is_file(), Path(path).glob('*'))
            self.files = [f for f in files if f.suffix in extensions]
            self.logger.debug(f"Files read: {self.files}")
        except FileNotFoundError as e:
            self.logger.exception(f"File/directory not found: {path}")
        return self.files

    def parse_volumes(self):
        self.logger.debug("Parsing volumes...")
        files = self.files
        parse_string = r'\b(?:volume|vol|v)([0-9]{0,3})\b'
        volumes = {}
        for f in files:
            v = re.findall(parse_string, f.name)[0]
            if v is not None:
                try:
                    volumes[int(v)] = f
                except TypeError as e:
                    self.logger.exception(f"Could not cast {v} to int")
        self.volumes = volumes
        return self.volumes

    def parse_chapters(self, path):
        self.logger.debug("Parsing chapters...")
        parse_string = r'\b(?:chapter|ch|c)([0-9]{0,4}[x.-]?[0-9])\b'
        for f in path.glob('*'):
            c = re.findall(parse_string, f.name)[0]
            if c is not None:
                self.chapters.setdefault(c, []).append(f)
        return self.chapters

    def process_volumes(self):
        self.logger.debug("Extracting volumes...")
        for volume in self.volumes:
            vol_path = self.extract(self.volumes[volume])
            self.parse_chapters(vol_path)

    def process_chapters(self):
        self.logger.debug("Compressing chapters...")
        for chapter in self.chapters:
            out_path = self.out / (chapter + '.cbz')
            self.logger.debug(f"Compressing chapter {chapter} to {out_path}")
            self.compress(self.chapters[chapter], out_path)

    def neato(self, folder):
        # yes i'm giving this a dumb name
        self.read_files(folder)
        self.parse_volumes()
        self.process_volumes()
        self.process_chapters()
        self.logger.info("Cleaning up...")
        shutil.rmtree(self.tmp)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Organize manga from volumes into chapters, ready for Tachiyomi.")
    parser.add_argument('input', action='store', type=Path)
    parser.add_argument('output', action='store', type=Path)
    parser.add_argument('-v', '--verbose', action='count', default=0)
    parser.add_argument('--log-output', action='store', type=Path, default=None)

    args = parser.parse_args()

    logger = logging.getLogger(__name__)
    logger.addHandler(logging.NullHandler())

    if args.log_output is None:
        handler = logging.StreamHandler(sys.stdout)
    else:
        handler = logging.FileHandler(args.log_output, mode='a')
    logger.addHandler(handler)

    if args.verbose == 0:
        logger.setLevel(logging.INFO)
    elif args.verbose >= 1:
        logger.setLevel(logging.DEBUG)

    logger.info(f"It's Mango time!")
    mango = Mango(out_path=args.output)
    mango.neato(args.input)
