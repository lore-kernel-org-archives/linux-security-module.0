From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 15 Nov 2017 14:39:24 +0100
Subject: [USER SPACE][RFC][PATCH 3/5] digest-list-tools: tools
In-Reply-To: <20171115133926.20108-1-roberto.sassu@huawei.com>
References: <20171115133926.20108-1-roberto.sassu@huawei.com>
Message-ID: <20171115133926.20108-4-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch adds the tools necessary to generate/verify digest lists and
metadata.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 scripts/setup_ima_digest_list | 116 ++++++++++++++++++++
 src/gen_digest_lists.c        | 240 ++++++++++++++++++++++++++++++++++++++++++
 src/verify_digest_lists.c     | 135 ++++++++++++++++++++++++
 3 files changed, 491 insertions(+)
 create mode 100644 scripts/setup_ima_digest_list
 create mode 100644 src/gen_digest_lists.c
 create mode 100644 src/verify_digest_lists.c

diff --git a/scripts/setup_ima_digest_list b/scripts/setup_ima_digest_list
new file mode 100644
index 0000000..38953f6
--- /dev/null
+++ b/scripts/setup_ima_digest_list
@@ -0,0 +1,116 @@
+#! /bin/bash
+
+# Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH
+#
+# Author: Roberto Sassu <roberto.sassu@huawei.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation, version 2 of the
+# License.
+#
+# File: setup_ima_digest_list
+#      Configure digest lists
+
+set -f
+
+function usage() {
+    echo "Usage: $0 initial|immutable|mutable [options]"
+    echo "Options:"
+    echo -e "\t-d <directory>: directory where digest lists and metadata are stored"
+    echo -e "\t-e <algorithm>: digest algorithm"
+    echo -e "\t-a: append metadata"
+}
+
+if [ "$1" != "initial" ] && [ "$1" != "immutable" ] && [ "$1" != "mutable" ]; then
+    usage
+    exit 1
+fi
+
+OPTIND=2
+digest_lists_dir="/etc/ima/digest_lists"
+algorithm="sha256"
+gen_digest_lists_result=0
+
+while getopts "h?d:e:a" opt; do
+    case "$opt" in
+    h|\?)
+        usage
+        exit 0
+        ;;
+    d)  digest_lists_dir=$OPTARG
+        ;;
+    e)  algorithm=$OPTARG
+        ;;
+    a)  gen_digest_lists_opt="-a"
+        ;;
+    esac
+done
+
+if [ -z "$gen_digest_lists_opt" ] && [ -d "$digest_lists_dir" ]; then
+    ls_output=$(ls $digest_lists_dir)
+    if [ -n "$ls_output" ]; then
+        echo "$digest_lists_dir not empty, files will be overwritten. Do you want to continue? [y/N]"
+        read answer
+
+        if [ "$answer" != "y" ]; then
+            echo "Exiting."
+            exit 0
+        fi
+    fi
+else
+    mkdir -p $digest_lists_dir
+fi
+
+if [ "$1" = "initial" ]; then
+    # generate digest lists from RPM database
+    echo "Generate initial digest list from RPM database"
+    gen_digest_lists $gen_digest_lists_opt -e $algorithm -d $digest_lists_dir -o rpm
+    gen_digest_lists_result=$?
+elif [ "$1" = "immutable" ]; then
+    filename="$digest_lists_dir/unknown_digests_immutable"
+    find_opt="! -path /var/* ! -path /boot/*"
+    awk_opt='$5 !~ /^\/var/'
+elif [ "$1" = "mutable" ]; then
+    # required if root filesystem is mounted as read-only
+    mount -t tmpfs none /var/tmp
+    cp -a /etc/ima/digest_lists /var/tmp
+    mount -t tmpfs none /etc/ima/digest_lists
+    cp -a /var/tmp/digest_lists /etc/ima
+
+    filename="/etc/ima/digest_lists/unknown_digests_mutable"
+    gen_digest_lists_opt="$gen_digest_lists_opt -w"
+    awk_opt='{print $0}'
+fi
+
+if [ -n "$filename" ]; then
+    # find unknown files in the root filesystem
+    echo "Read files from / and /boot"
+    find / /boot -xdev -type f -uid 0 $find_opt -exec head -c0 \{} \;
+
+    # create an ASCII file containing the digests of unknown measurements
+    echo "Create $filename with digests of unknown files"
+    cat /sys/kernel/security/ima/ascii_runtime_measurements | awk "$awk_opt" | \
+        awk '$4 != "sha1:0000000000000000000000000000000000000000" {print $4, $5}' > $filename
+
+    # edit the list of unknown digests
+    vi $filename
+
+    # create a digest list with the digest of immutable or mutable files
+    echo "Generate compact list from $filename"
+    gen_digest_lists -e $algorithm -d /etc/ima/digest_lists -f ascii -i $filename $gen_digest_lists_opt
+    gen_digest_lists_result=$?
+fi
+
+if [ $gen_digest_lists_result -eq 0 ]; then
+    # update initial ram disk
+    echo "Update initial ram disk"
+    dracut -f -i /etc/ima /etc/ima
+fi
+
+if [ "$1" = "mutable" ]; then
+    umount /var/tmp
+    umount /etc/ima/digest_lists
+fi
+
+set +f
diff --git a/src/gen_digest_lists.c b/src/gen_digest_lists.c
new file mode 100644
index 0000000..d212942
--- /dev/null
+++ b/src/gen_digest_lists.c
@@ -0,0 +1,240 @@
+/*
+ * Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: gen_digest_lists.c
+ *      Handles command line options and retrieve digests.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+
+#include "metadata.h"
+
+static int digest_list_from_rpmdb(char *outdir, char *metadata_filename,
+				  enum digest_data_types output_fmt)
+{
+	rpmts ts = NULL;
+	Header hdr;
+	rpmdbMatchIterator mi;
+	int ret;
+
+	ts = rpmtsCreate();
+	ret = rpmReadConfigFiles(NULL, NULL);
+	if (ret != RPMRC_OK) {
+		rpmlog(RPMLOG_NOTICE, "Unable to read RPM configuration.\n");
+		exit(1);
+	}
+
+	mi = rpmtsInitIterator(ts, RPMDBI_PACKAGES, NULL, 0);
+	while ((hdr = rpmdbNextIterator(mi)) != NULL) {
+		hdr = headerLink(hdr);
+
+		ret = write_digests_and_metadata(hdr, outdir, metadata_filename,
+						 INPUT_FMT_RPMDB, NULL,
+						 output_fmt, 0);
+		if (ret < 0)
+			break;
+
+		headerFree(hdr);
+	}
+
+	rpmdbFreeIterator(mi);
+	rpmtsFree(ts);
+	return ret;
+}
+
+int digest_lists_from_rpmpkg(char *outdir, char *metadata_filename,
+			     char *package_path,
+			     enum digest_data_types output_fmt)
+{
+	Header hdr;
+	rpmts ts = NULL;
+	FD_t fd;
+	int ret;
+
+	fd = Fopen(package_path, "r.ufdio");
+	if ((!fd) || Ferror(fd)) {
+		rpmlog(RPMLOG_NOTICE, "Failed to open package file (%s)\n",
+		       Fstrerror(fd));
+		if (fd)
+			Fclose(fd);
+
+		return -EINVAL;
+	}
+
+	ret = rpmReadPackageFile(ts, fd, package_path, &hdr);
+	if (ret != RPMRC_OK) {
+		rpmlog(RPMLOG_NOTICE, "Could not read package file\n");
+			Fclose(fd);
+			exit(1);
+	}
+
+	Fclose(fd);
+	ret = write_digests_and_metadata(hdr, outdir, metadata_filename,
+					 INPUT_FMT_RPMPKG, NULL, output_fmt, 0);
+	rpmtsFree(ts);
+	return ret;
+}
+
+int write_digest_lists(char *outdir, char *metadata_filename,
+		       int add_metadata, enum input_formats input_fmt,
+		       char *input_filename, enum digest_data_types output_fmt,
+		       int is_mutable)
+{
+	char filename[MAX_FILENAME_LENGTH];
+	int ret = 0, fd;
+
+	snprintf(filename, sizeof(filename), "%s/%s", outdir,
+		 metadata_filename);
+
+	fd = open(filename, O_WRONLY | O_CREAT, 0600);
+	if (fd < 0) {
+		printf("Unable to write metadata file %s\n", filename);
+		return -EACCES;
+	}
+
+	if (!add_metadata)
+		ftruncate(fd, 0);
+
+	switch (input_fmt) {
+	case INPUT_FMT_RPMDB:
+		ret = digest_list_from_rpmdb(outdir, filename, output_fmt);
+		break;
+	case INPUT_FMT_RPMPKG:
+		ret = digest_lists_from_rpmpkg(outdir, filename, input_filename,
+					       output_fmt);
+		break;
+	case INPUT_FMT_DIGEST_LIST_ASCII:
+		ret = write_digests_and_metadata(NULL, outdir, filename,
+						 INPUT_FMT_DIGEST_LIST_ASCII,
+						 input_filename, output_fmt,
+						 is_mutable);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+void usage(char *progname)
+{
+	printf("Usage: %s <options>\n", progname);
+	printf("Options:\n");
+	printf("\t-a: append metadata to an existing file\n"
+	       "\t-d <directory>: directory where digest lists and metadata "
+	       "are stored\n"
+	       "\t-f <input format>: format of the input where digests "
+	       "are taken from\n"
+	       "\t\trpmdb: RPM database\n"
+	       "\t\trpmpkg: RPM package\n"
+	       "\t\tascii: file containing ASCII digests for each line\n"
+	       "\t-h: display help\n"
+	       "\t-i <path>: path of the file where digests are taken from\n"
+	       "\t-m <file name>: metadata file name\n"
+	       "\t-o <output format>: output format of the digest list\n"
+	       "\t\tcompact: compact digest list\n"
+	       "\t\trpm: RPM package header\n"
+	       "\t-w: files are mutable\n"
+	       "\t-e <algorithm>: digest algorithm\n");
+}
+
+int main(int argc, char **argv)
+{
+	int add_metadata = 0, is_mutable = 0;
+	char *input_filename = NULL, *metadata_filename = "metadata";
+	char *outdir = NULL;
+	enum input_formats input_fmt = INPUT_FMT_RPMDB;
+	enum digest_data_types output_fmt = DATA_TYPE_COMPACT_LIST;
+	int c, ret;
+
+	while ((c = getopt(argc, argv, "ad:f:i:m:o:hwe:")) != -1) {
+		switch (c) {
+		case 'a':
+			add_metadata = 1;
+			break;
+		case 'd':
+			outdir = optarg;
+			break;
+		case 'f':
+			if (strcmp(optarg, "rpmdb") == 0) {
+				input_fmt = INPUT_FMT_RPMDB;
+			} else if (strcmp(optarg, "rpmpkg") == 0) {
+				input_fmt = INPUT_FMT_RPMPKG;
+			} else if (strcmp(optarg, "ascii") == 0) {
+				input_fmt = INPUT_FMT_DIGEST_LIST_ASCII;
+			} else {
+				printf("Unknown input format %s\n", optarg);
+				return -EINVAL;
+			}
+			break;
+		case 'h':
+			usage(argv[0]);
+			return -EINVAL;
+		case 'i':
+			input_filename = optarg;
+			break;
+		case 'm':
+			metadata_filename = optarg;
+			break;
+		case 'o':
+			if (strcmp(optarg, "compact") == 0) {
+				output_fmt = DATA_TYPE_COMPACT_LIST;
+			} else if (strcmp(optarg, "rpm") == 0) {
+				output_fmt = DATA_TYPE_RPM;
+			} else {
+				printf("Unknown output format %s\n", optarg);
+				return -EINVAL;
+			}
+			break;
+		case 'w':
+			is_mutable = 1;
+			break;
+		case 'e':
+			if (ima_hash_setup(optarg)) {
+				printf("Unknown algorithm %s\n", optarg);
+				return -EINVAL;
+			}
+			break;
+		default:
+			printf("Unknown option %c\n", optopt);
+			return -EINVAL;
+		}
+	}
+
+	if (input_fmt != INPUT_FMT_RPMDB && input_filename == NULL) {
+		printf("Input file not specified\n");
+		return -EINVAL;
+	}
+
+	if (input_fmt == INPUT_FMT_RPMDB && input_filename != NULL) {
+		printf("Input file format not specified\n");
+		return -EINVAL;
+	}
+
+	if (outdir == NULL) {
+		printf("Output directory not specified\n");
+		return -EINVAL;
+	}
+
+	if (outdir[0] != '/') {
+		printf("Absolute path of output directory must be specified\n");
+		return -EINVAL;
+	}
+
+	OpenSSL_add_all_digests();
+
+	ret = write_digest_lists(outdir, metadata_filename, add_metadata,
+				 input_fmt, input_filename, output_fmt,
+				 is_mutable);
+	EVP_cleanup();
+	return ret;
+}
diff --git a/src/verify_digest_lists.c b/src/verify_digest_lists.c
new file mode 100644
index 0000000..dfe7162
--- /dev/null
+++ b/src/verify_digest_lists.c
@@ -0,0 +1,135 @@
+/*
+ * Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: verify_digest_lists.c
+ *      Verify digest list metadata and digest lists
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include "kernel_ima.h"
+#include "lib.h"
+
+int verify_list_metadata(char *path, u8 *digest, int *num_digest_lists,
+			 int *num_digests)
+{
+	int digest_len = hash_digest_size[ima_hash_algo];
+	u8 metadata_digest[digest_len];
+	void *data, *datap;
+	loff_t size, mmap_size, cur_size = 0;
+	int digest_lists = 0;
+	int ret, fd;
+
+	fd = kernel_read_file_from_path(path, &data, &size, 0,
+					READING_DIGEST_LIST_METADATA);
+	if (fd < 0) {
+		pr_err("Unable to read: %s (%d)\n", path, fd);
+		return fd;
+	}
+
+	mmap_size = size;
+
+	ret = calc_digest(metadata_digest, data, size, ima_hash_algo);
+	if (ret < 0)
+		goto out;
+
+	if (memcmp(metadata_digest, digest, digest_len) != 0) {
+		pr_err("%s: integrity check failed\n", path);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	datap = data;
+	while (size > 0) {
+		cur_size = ima_parse_digest_list_metadata(size, datap);
+		if (cur_size < 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		size -= cur_size;
+		datap += cur_size;
+		digest_lists++;
+	}
+
+	*num_digest_lists = digest_lists;
+	*num_digests = digests;
+out:
+	munmap(data, mmap_size);
+	return ret;
+}
+
+void usage(char *progname)
+{
+	printf("Usage: %s <options>\n", progname);
+	printf("Options:\n");
+	printf("\t-d: directory containing metadata and digest lists\n"
+	       "\t-m <file name>: metadata file name\n"
+	       "\t-i <digest>: expected digest of metadata\n"
+	       "\t-h: display help\n"
+	       "\t-e <algorithm>: digest algorithm\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int c, digest_len, num_digest_lists, num_digests, ret = -EINVAL;
+	u8 input_digest[SHA512_DIGEST_SIZE];
+	char *digest_ptr = NULL, *cur_dir = "./";
+	char *metadata_filename = "metadata";
+
+	while ((c = getopt(argc, argv, "d:m:i:he:")) != -1) {
+		switch (c) {
+		case 'd':
+			cur_dir = optarg;
+			break;
+		case 'm':
+			metadata_filename = optarg;
+			break;
+		case 'i':
+			digest_ptr = optarg;
+			break;
+		case 'h':
+			usage(argv[0]);
+			return -EINVAL;
+		case 'e':
+			if (ima_hash_setup(optarg)) {
+				printf("Unknown algorithm %s\n", optarg);
+				return -EINVAL;
+			}
+			break;
+		default:
+			printf("Unknown option %c\n", optopt);
+			return -EINVAL;
+		}
+	}
+
+	if (digest_ptr == NULL) {
+		printf("Expected metadata digest not specified\n");
+		return -EINVAL;
+	}
+
+	digest_list_path = cur_dir;
+
+	OpenSSL_add_all_digests();
+
+	digest_len = hash_digest_size[ima_hash_algo];
+	hex2bin(input_digest, digest_ptr, digest_len);
+
+	ret = verify_list_metadata(metadata_filename, input_digest,
+				   &num_digest_lists, &num_digests);
+	if (ret == 0)
+		printf("num_digest_lists: %d, num_digests: %d\n",
+		       num_digest_lists, num_digests);
+
+	EVP_cleanup();
+	return ret;
+}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
