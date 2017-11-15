From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 15 Nov 2017 14:41:27 +0100
Subject: [USER SPACE][RFC][PATCH 5/5] digest-list-tools: package
Message-ID: <20171115134127.20423-1-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch adds package-specific files.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .gitignore          | 28 ++++++++++++++++++++++++++++
 AUTHORS             | 10 ++++++++++
 CHANGES             |  3 +++
 LICENSE             |  3 +++
 Makefile.am         |  9 +++++++++
 configure.ac        | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 docs/Makefile.am    |  3 +++
 include/Makefile.am |  6 ++++++
 lib/Makefile.am     | 12 ++++++++++++
 scripts/Makefile.am |  1 +
 src/Makefile.am     |  9 +++++++++
 11 files changed, 134 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 AUTHORS
 create mode 100644 CHANGES
 create mode 100644 LICENSE
 create mode 100644 Makefile.am
 create mode 100644 configure.ac
 create mode 100644 docs/Makefile.am
 create mode 100644 include/Makefile.am
 create mode 100644 lib/Makefile.am
 create mode 100644 scripts/Makefile.am
 create mode 100644 src/Makefile.am

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..4f8d990
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,28 @@
+*.o
+src/gen_digest_lists
+src/verify_digest_lists
+*Makefile.in
+*Makefile
+
+ar-lib
+config.h
+config.h.in
+configure.scan
+stamp-h1
+aclocal.m4
+autom4te.cache/
+compile
+config.log
+config.status
+config.sub
+config.guess
+configure
+depcomp
+install-sh
+missing
+libtool
+ltmain.sh
+*/.deps/
+*/.libs/
+*.lo
+*.la
diff --git a/AUTHORS b/AUTHORS
new file mode 100644
index 0000000..a83669f
--- /dev/null
+++ b/AUTHORS
@@ -0,0 +1,10 @@
+Roberto Sassu, Huawei Technologies Duesseldorf GmbH
+
+Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH
+
+All rights reserved.
+
+This program is free software; you can redistribute it and/or
+modify it under the terms of the GNU General Public License as
+published by the Free Software Foundation, version 2 of the
+License.
diff --git a/CHANGES b/CHANGES
new file mode 100644
index 0000000..5580d89
--- /dev/null
+++ b/CHANGES
@@ -0,0 +1,3 @@
+2017-11-15  Roberto Sassu <roberto.sassu@huawei.com>
+	version 0.1
+	* first public release
diff --git a/LICENSE b/LICENSE
new file mode 100644
index 0000000..efe1bf0
--- /dev/null
+++ b/LICENSE
@@ -0,0 +1,3 @@
+A copy of the GPL 2 license can be retrieved from:
+
+https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
diff --git a/Makefile.am b/Makefile.am
new file mode 100644
index 0000000..f62a6ff
--- /dev/null
+++ b/Makefile.am
@@ -0,0 +1,9 @@
+SUBDIRS = docs \
+	  lib \
+	  scripts \
+	  src
+
+EXTRA_DIST = AUTHORS \
+	     CHANGES
+
+dist_pkgdata_DATA = README
diff --git a/configure.ac b/configure.ac
new file mode 100644
index 0000000..34244ab
--- /dev/null
+++ b/configure.ac
@@ -0,0 +1,50 @@
+#                                               -*- Autoconf -*-
+# Process this file with autoconf to produce a configure script.
+
+AC_PREREQ([2.69])
+AC_INIT([digest-list-tools], [0.1], [roberto.sassu at huawei.com])
+AC_CONFIG_HEADERS([config.h])
+CFLAGS="$CFLAGS -Wall"
+
+AM_INIT_AUTOMAKE([-Wall foreign])
+AM_PROG_AR
+AC_PROG_CC
+LT_INIT
+
+# Checks for programs.
+AC_PROG_CXX
+AC_PROG_AWK
+AC_PROG_CC
+AC_PROG_CPP
+AC_PROG_INSTALL
+AC_PROG_LN_S
+AC_PROG_MAKE_SET
+AC_PROG_RANLIB
+
+# Checks for libraries.
+AC_CHECK_LIB([crypto], [SHA256_Init])
+AC_CHECK_LIB([rpm], [headerGetEntry])
+AC_CHECK_LIB([rpmio], [Fopen])
+
+# Checks for header files.
+AC_CHECK_HEADERS([fcntl.h stdlib.h string.h unistd.h])
+
+# Checks for typedefs, structures, and compiler characteristics.
+AC_CHECK_HEADER_STDBOOL
+AC_C_INLINE
+AC_TYPE_INT32_T
+AC_TYPE_SIZE_T
+AC_TYPE_SSIZE_T
+
+# Checks for library functions.
+AC_FUNC_MALLOC
+AC_FUNC_MMAP
+AC_CHECK_FUNCS([ftruncate memset munmap strstr])
+
+AC_CONFIG_FILES([Makefile
+                 docs/Makefile
+                 include/Makefile
+                 lib/Makefile
+                 src/Makefile
+                 scripts/Makefile])
+AC_OUTPUT
diff --git a/docs/Makefile.am b/docs/Makefile.am
new file mode 100644
index 0000000..5b1c1a2
--- /dev/null
+++ b/docs/Makefile.am
@@ -0,0 +1,3 @@
+dist_pkgdata_DATA = gen_digest_lists.txt \
+                    setup_ima_digest_list.txt \
+                    verify_digest_lists.txt
diff --git a/include/Makefile.am b/include/Makefile.am
new file mode 100644
index 0000000..a807be0
--- /dev/null
+++ b/include/Makefile.am
@@ -0,0 +1,6 @@
+noinst_HEADERS = kernel_lib.h \
+		 kernel_ima.h \
+		 compact_list.h \
+		 rpm.h \
+		 metadata.h \
+		 lib.h
diff --git a/lib/Makefile.am b/lib/Makefile.am
new file mode 100644
index 0000000..3472a06
--- /dev/null
+++ b/lib/Makefile.am
@@ -0,0 +1,12 @@
+lib_LTLIBRARIES = libdigestlists.la
+
+libdigestlists_la_LIBADD = -lcrypto -lrpm -lrpmio
+
+libdigestlists_la_CFLAGS = -I$(top_srcdir)/include
+
+libdigestlists_la_SOURCES = kernel_lib.c \
+			    kernel_ima.c \
+			    compact_list.c \
+			    rpm.c \
+			    metadata.c \
+			    lib.c
diff --git a/scripts/Makefile.am b/scripts/Makefile.am
new file mode 100644
index 0000000..468d768
--- /dev/null
+++ b/scripts/Makefile.am
@@ -0,0 +1 @@
+bin_SCRIPTS = setup_ima_digest_list
diff --git a/src/Makefile.am b/src/Makefile.am
new file mode 100644
index 0000000..3446e3d
--- /dev/null
+++ b/src/Makefile.am
@@ -0,0 +1,9 @@
+bin_PROGRAMS = gen_digest_lists verify_digest_lists
+
+gen_digest_lists_CFLAGS = -I$(top_srcdir)/include
+gen_digest_lists_LDADD = $(top_srcdir)/lib/libdigestlists.la -lcrypto -lrpm -lrpmio
+gen_digest_lists_SOURCES = gen_digest_lists.c
+
+verify_digest_lists_CFLAGS = -I$(top_srcdir)/include
+verify_digest_lists_LDADD = $(top_srcdir)/lib/libdigestlists.la -lcrypto -lrpm -lrpmio
+verify_digest_lists_SOURCES = verify_digest_lists.c
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
