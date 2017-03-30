From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Thu, 30 Mar 2017 17:11:27 -0300
Subject: [PATCH 0/9] convert genericirq.tmpl and kernel-api.tmpl to DocBook
Message-ID: <cover.1490904090.git.mchehab@s-opensource.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jani proposed to batch-convert the remaining DocBooks for us
to get rid of it.

Well, I tried ;) 

The conversion itself can easily done, but the problem is that
it hits several errors/warnings when parsing kernel-doc tags.

It ends that it takes some time to fix those.

Also, it seems that the "!I" and "!E" tags at the DocBook
template are not quite right. So, despite being properly
converted to the corresponding kernel-doc tags at ReST, they
didn't produce all that it was needed. I manually fixed a
few, but I guess there are more to be fixed there. Anyway,
this is something that the subsystem maintainers can fix later,
as they understand better what functions they want exported at
the public API documentation, and what functions they want to
hide.

This series converts just two documents, adding them to the
core-api.rst book. It addresses the errors/warnings that popup
after the conversion.

I had to add two fixes to scripts/kernel-doc, in order to solve
some of the issues.

If I have some time during this weekend, I may try to convert
some additional documents to DocBook.


Mauro Carvalho Chehab (9):
  scripts/kernel-doc: fix parser for apostrophes
  scripts/kernel-doc: fix handling of parameters with parenthesis
  genericirq.tmpl: convert it to ReST
  genericirq.rst: add cross-reference links and use monospaced fonts
  kernel-api.tmpl: convert it to ReST
  kernel-api.rst: fix output of the vsnprintf() documentation
  kernel-api.rst: make it handle lib/crc32.c
  kernel-api.rst: fix some complex tags at lib/bitmap.c
  kernel-api.rst: fix a series of errors when parsing C files

 Documentation/DocBook/Makefile        |   4 +-
 Documentation/DocBook/genericirq.tmpl | 520 ----------------------------------
 Documentation/DocBook/kernel-api.tmpl | 331 ----------------------
 Documentation/core-api/genericirq.rst | 440 ++++++++++++++++++++++++++++
 Documentation/core-api/index.rst      |   2 +
 Documentation/core-api/kernel-api.rst | 418 +++++++++++++++++++++++++++
 block/genhd.c                         |   7 +-
 drivers/pci/irq.c                     |   2 +-
 include/linux/clk.h                   |   4 +-
 ipc/util.c                            |  12 +-
 lib/bitmap.c                          |  28 +-
 lib/string.c                          |   2 +-
 lib/vsprintf.c                        |   6 +-
 mm/filemap.c                          |  18 +-
 mm/page_alloc.c                       |   3 +-
 mm/vmalloc.c                          |   2 +-
 scripts/kernel-doc                    |  19 +-
 security/security.c                   |  12 +-
 18 files changed, 932 insertions(+), 898 deletions(-)
 delete mode 100644 Documentation/DocBook/genericirq.tmpl
 delete mode 100644 Documentation/DocBook/kernel-api.tmpl
 create mode 100644 Documentation/core-api/genericirq.rst
 create mode 100644 Documentation/core-api/kernel-api.rst

-- 
2.9.3


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
