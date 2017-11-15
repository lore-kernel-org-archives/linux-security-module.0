From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 15 Nov 2017 14:39:25 +0100
Subject: [USER SPACE][RFC][PATCH 4/5] digest-list-tools: documentation
In-Reply-To: <20171115133926.20108-1-roberto.sassu@huawei.com>
References: <20171115133926.20108-1-roberto.sassu@huawei.com>
Message-ID: <20171115133926.20108-5-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch adds the documentation of the digest-list-tools package.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 README                         | 143 +++++++++++++++++++++++++++++++++++++++++
 docs/gen_digest_lists.txt      |  87 +++++++++++++++++++++++++
 docs/setup_ima_digest_list.txt |  51 +++++++++++++++
 docs/verify_digest_lists.txt   |  52 +++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 README
 create mode 100644 docs/gen_digest_lists.txt
 create mode 100644 docs/setup_ima_digest_list.txt
 create mode 100644 docs/verify_digest_lists.txt

diff --git a/README b/README
new file mode 100644
index 0000000..e0a2a34
--- /dev/null
+++ b/README
@@ -0,0 +1,143 @@
+======
+README
+======
+
+IMA Boot-time Configuration
+===========================
+
+This section explains how to generate digest lists and how to include them into
+an initial ram disk, so that generated digest lists are loaded early in the boot
+process.
+
+Measurement
+-----------
+
+Follow these steps to create digest lists from installed packages:
+
+1) execute setup_ima_digest_list
+
+# setup_ima_digest_list initial -e <value of ima_hash kernel parameter>
+
+This command creates a file containing the RPM header for each installed package
+and writes them to /etc/ima/digest_lists. Metadata are saved to
+/etc/ima/digest_lists/metadata. If the RPM database is not available, digest
+lists can be generated directly from the measurement list. Follow the steps
+below, for generating the digest list of immutable and mutable files (the -a
+option of setup_ima_digest_list can be removed for immutable files).
+
+2) edit the bootloader configuration file and add 'ima_policy=tcb' to the kernel
+   command line
+
+3) reboot
+
+After reboot, the measurement list will contain only unknown files. It is
+possible to create the initial digest list without the RPM database with the
+steps below. The initial digest list will be created from the measurement list.
+
+
+Follow these steps to add an additional digest list with digests of immutable
+files:
+
+1) execute setup_ima_digest_list
+
+# setup_ima_digest_list immutable -a -e <value of ima_hash kernel parameter>
+
+This command reads files from the root filesystem, so that IMA creates a new
+measurement entry if the calculate digest is not included in the currently
+loaded digest lists. Afterwards, the vi editor is automatically opened so that
+users can select the digests to include in the new digest list. The new list
+will be saved to /etc/ima/digest_lists/compact-unknown_digests_immutable, and a
+new record will be added to /etc/ima/digest_lists/metadata.
+
+2) reboot
+
+
+
+Appraisal
+---------
+
+To enable appraisal with digest list, it is necessary to mount the filesystem
+as read-only, to calculate the correct digest of mutable files. Otherwise, if
+those files are written before reboot, IMA will deny access to them, because the
+new digest will not be found.
+
+1) copy /etc/fstab to /etc/fstab.orig
+
+2) edit /etc/fstab and add 'ro' mount option for the root filesystem
+
+3) remove security.ima and security.evm extended attributes
+
+# find / -xdev -uid 0 -type f -exec attr -S -r ima 2> /dev/null \{} \;
+
+# find / -xdev -uid 0 -type f -exec attr -S -r evm 2> /dev/null \{} \;
+
+4) reboot
+
+5) execute setup_ima_digest_list
+
+# setup_ima_digest_list mutable -a -e <value of ima_hash kernel parameter>
+
+This command reads files in / and /boot. Since the initial and immutable digest
+lists have been loaded, IMA creates a new measurement entry for each mutable
+file. The user can select the digests after the vi editor is opened, and a new
+digest list is saved to /etc/ima/digest_lists/compact-unknown_digests_mutable.
+/etc/ima/digest_lists/metadata is also updated.
+
+6) edit the bootloader configuration file and add 'ima_policy=appraise_tcb
+   evm_xattrs=security.ima' to the kernel command line
+
+7) reboot
+
+8) remount the root filesystem as read-write
+
+# mount -o remount,rw /
+
+9) restore the original /etc/fstab
+
+10) reboot
+
+'evm_xattrs=security.ima' should be used only if no additional metadata should
+be protected by EVM. If it has been specified, security.ima will be created only
+for mutable files. Otherwise, they will be created also for immutable files.
+
+
+
+
+IMA Run-time Configuration
+==========================
+
+This section explains how to generate additional digest lists and how to upload
+them to IMA, when the system is running.
+
+Generation
+----------
+
+Digest lists can be generated with the gen_digest_lists tool. A description of
+this command can be found in docs/gen_digest_lists.txt.
+
+
+
+Upload
+------
+
+After digest lists have been generated, they can be uploaded by writing the path
+of digest list metadata to /sys/kernel/security/ima/digest_lists. For example:
+
+echo "/etc/ima/digest_lists/metadata" > /sys/kernel/security/ima/digest_lists
+
+
+
+Digest List Integrity Verification
+==================================
+
+The measurement list, after loading the digest lists will look like:
+
+10 <template digest> ima-ng sha1:<digest> boot_aggregate
+10 <template digest> ima-ng sha1:<digest> /etc/ima/digest_lists/metadata
+<measurement entries for modified mutable files>
+
+An attestation server can use the verify_digest_lists tool to verify the
+integrity of metadata and digest lists. For example, it can execute:
+
+$ verify_digest_lists -d /etc/ima/digest_lists -m metadata -e sha256 \
+                      -i <metadata digest>
diff --git a/docs/gen_digest_lists.txt b/docs/gen_digest_lists.txt
new file mode 100644
index 0000000..1d3c39e
--- /dev/null
+++ b/docs/gen_digest_lists.txt
@@ -0,0 +1,87 @@
+gen_digest_lists
+================
+
+gen_digest_lists
+----------------
+
+gen_digest_lists - generate a digest list
+
+
+SYNOPSIS
+--------
+
+gen_digest_lists [options]
+
+
+DESCRIPTION
+-----------
+
+gen_digest_lists can be used to generate digest lists from the RPM database,
+from an RPM package, or from a list of digests in ASCII format.
+
+
+OPTIONS
+-------
+
+-a: append metadata to an existing file
+-d <directory>: directory where digest lists and metadata are stored
+-f <input format>: format of the input where digests are taken from
+                   - rpmdb: RPM database (default)
+                   - rpmpkg: RPM package
+                   - ascii: ASCII file with format <algo>:<digest> for each line
+-h: display help
+-i <path>: path of the file where digests are taken from
+-m <file name>: metadata file name (default: metadata)
+-o <output format>: output format of the digest list
+                    - compact: compact digest list (default)
+                    - rpm: RPM package header
+-w: files are mutable
+-e <algorithm>: digest algorithm
+
+
+EXAMPLES
+--------
+
+Generate an ASCII digest list for each installed RPM package and copy it to
+/etc/ima/digest_lists.
+
+$ gen_digest_lists -d /etc/ima/digest_lists
+
+Generate an RPM digest list for each installed RPM package and copy it to
+/etc/ima/digest_lists.
+
+$ gen_digest_lists -d /etc/ima/digest_lists -o rpm
+
+Generate an RPM digest list from an RPM package and copy it to
+/etc/ima/digest_lists.
+
+$ gen_digest_lists -d /etc/ima/digest_lists -f rpmpkg -i <RPM package>
+
+Generate an ASCII digest list from a file containing digests of immutable files
+and copy it to /etc/ima/digest_lists.
+
+$ gen_digest_lists -d /etc/ima/digest_lists -f ascii -i <ASCII file>
+
+Generate an ASCII digest list from a file containing digests of mutable files
+and copy it to /etc/ima/digest_lists.
+
+$ gen_digest_lists -d /etc/ima/digest_lists -f ascii -i <ASCII file> -w
+
+Generate an ASCII digest list from a file containing digests of mutable files
+and copy it to /etc/ima/digest_lists. Append digest list metadata to
+/etc/ima/digest_lists/metadata.
+
+$ gen_digest_lists -d /etc/ima/digest_lists -f ascii -i <ASCII file> -w -a
+
+
+AUTHOR
+------
+
+Written by Roberto Sassu, <roberto.sassu@huawei.com>.
+
+
+COPYING
+-------
+
+Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH. Free use of this
+software is granted under the terms of the GNU Public License (GPL).
diff --git a/docs/setup_ima_digest_list.txt b/docs/setup_ima_digest_list.txt
new file mode 100644
index 0000000..cec17a2
--- /dev/null
+++ b/docs/setup_ima_digest_list.txt
@@ -0,0 +1,51 @@
+setup_ima_digest_list
+=====================
+
+setup_ima_digest_list
+---------------------
+
+setup_ima_digest_list - generate digest lists for measurement and appraisal
+
+
+SYNOPSIS
+--------
+
+setup_ima_digest_list initial|immutable|mutable [options]
+
+
+DESCRIPTION
+-----------
+
+setup_ima_digest_list can be used to generate digest lists for measurement and
+appraisal. Digest lists can be generated from the RPM database, or from the
+IMA measurement list.
+
+
+COMMANDS
+--------
+
+initial: generate digest lists from the RPM database
+immutable: generate a digest list of immutable files from the measurement list
+mutable: generate a digest list of mutable files from the measurement list
+
+
+OPTIONS
+-------
+
+-h -?: display help
+-d <directory>: directory where digest lists and metadata are stored
+-e <algorithm>: digest algorithm
+-a: append metadata
+
+
+AUTHOR
+------
+
+Written by Roberto Sassu, <roberto.sassu@huawei.com>.
+
+
+COPYING
+-------
+
+Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH. Free use of this
+software is granted under the terms of the GNU Public License (GPL).
diff --git a/docs/verify_digest_lists.txt b/docs/verify_digest_lists.txt
new file mode 100644
index 0000000..7d5543d
--- /dev/null
+++ b/docs/verify_digest_lists.txt
@@ -0,0 +1,52 @@
+verify_digest_lists
+===================
+
+verify_digest_lists
+-------------------
+
+verify_digest_lists - verify integrity of digest lists metadata and digest lists
+
+
+SYNOPSIS
+--------
+
+verify_digest_lists [options]
+
+
+DESCRIPTION
+-----------
+
+verify_digest_lists can be used to verify the integrity of digest lists.
+
+
+OPTIONS
+-------
+
+-d <directory>: directory where digest lists and metadata are stored
+                (default: current directory)
+-m <file name>: metadata file name (default: metadata)
+-i <digest>: expected metadata digest
+-h: display help
+-e <algorithm>: digest algorithm
+
+
+EXAMPLES
+--------
+
+Verify digest lists metadata and digest list stored in /etc/ima/digest_lists.
+
+$ verify_digest_lists -d /etc/ima/digest_lists -m metadata -e sha256 \
+                      -i <metadata digest>
+
+
+AUTHOR
+------
+
+Written by Roberto Sassu, <roberto.sassu@huawei.com>.
+
+
+COPYING
+-------
+
+Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH. Free use of this
+software is granted under the terms of the GNU Public License (GPL).
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
