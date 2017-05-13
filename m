From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Sat, 13 May 2017 08:10:53 -0300
Subject: [PATCH 0/5] Convert more books to ReST
Message-ID: <cover.1494672881.git.mchehab@s-opensource.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch series convert the following books to ReST:
	- librs
	- mtdnand
	- sh

And it is based on my previous series of conversion patches.

After this series, there will be just one DocBook pending conversion:
	- lsm (Linux Security Modules)

This book is very outdated: no changes since the Kernel moved 
to git, in 2005 (except for a minor editorial fix in 2008).

I took a look on the described API: it doesn't seem to be describing
the current security implementation.

The best here is if someone that works with LSM to convert it to
ReST with:
	$ Documentation/sphinx/tmplcvt Documentation/DocBook/lsm.tmpl lsm.rst

And fix the document to produce something that reflects the current
implementation. If nobody is interested, then maybe we could just
drop it.

-

This patch series is based on my past 00/36 patch series, applied on
the top of docs tree (next branch).

The full patch series is on this tree is at:

   https://git.linuxtv.org//mchehab/experimental.git/log/?h=docbook

And the HTML output at:

  http://www.infradead.org/~mchehab/kernel_docs/
  https://mchehab.fedorapeople.org/kernel_docs/ 

Mauro Carvalho Chehab (5):
  docs-rst: convert librs book to ReST
  docs-rst: convert mtdnand book to ReST
  mtdnand.rst: Fix some typos and group the "::" with previous line
  mtd: adjust kernel-docs to avoid Sphinx/kerneldoc warnings
  docs-rst: convert sh book to ReST

 Documentation/DocBook/Makefile       |    5 +-
 Documentation/DocBook/librs.tmpl     |  289 --------
 Documentation/DocBook/mtdnand.tmpl   | 1291 ----------------------------------
 Documentation/DocBook/sh.tmpl        |  105 ---
 Documentation/conf.py                |    2 +
 Documentation/core-api/index.rst     |    1 +
 Documentation/core-api/librs.rst     |  212 ++++++
 Documentation/driver-api/index.rst   |    1 +
 Documentation/driver-api/mtdnand.rst | 1007 ++++++++++++++++++++++++++
 Documentation/index.rst              |   11 +
 Documentation/sh/index.rst           |   59 ++
 drivers/mtd/nand/nand_base.c         |    7 +-
 include/linux/mtd/nand.h             |    2 +-
 13 files changed, 1300 insertions(+), 1692 deletions(-)
 delete mode 100644 Documentation/DocBook/librs.tmpl
 delete mode 100644 Documentation/DocBook/mtdnand.tmpl
 delete mode 100644 Documentation/DocBook/sh.tmpl
 create mode 100644 Documentation/core-api/librs.rst
 create mode 100644 Documentation/driver-api/mtdnand.rst
 create mode 100644 Documentation/sh/index.rst

-- 
2.9.3


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
