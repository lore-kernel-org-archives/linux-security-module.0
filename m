From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Tue, 16 May 2017 07:38:49 -0300
Subject: [PATCH 0/5] Convert more books to ReST
In-Reply-To: <20170515140912.100c9cac@bbrezillon>
References: <cover.1494672881.git.mchehab@s-opensource.com>
	<20170515140912.100c9cac@bbrezillon>
Message-ID: <20170516073849.787750d4@vento.lan>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Em Mon, 15 May 2017 14:09:12 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> escreveu:

> On Sat, 13 May 2017 08:10:53 -0300
> Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:
> 
> > This patch series convert the following books to ReST:
> > 	- librs
> > 	- mtdnand
> > 	- sh
> > 
> > And it is based on my previous series of conversion patches.
> > 
> > After this series, there will be just one DocBook pending conversion:
> > 	- lsm (Linux Security Modules)
> > 
> > This book is very outdated: no changes since the Kernel moved 
> > to git, in 2005 (except for a minor editorial fix in 2008).
> > 
> > I took a look on the described API: it doesn't seem to be describing
> > the current security implementation.
> > 
> > The best here is if someone that works with LSM to convert it to
> > ReST with:
> > 	$ Documentation/sphinx/tmplcvt Documentation/DocBook/lsm.tmpl lsm.rst
> > 
> > And fix the document to produce something that reflects the current
> > implementation. If nobody is interested, then maybe we could just
> > drop it.
> > 
> > -
> > 
> > This patch series is based on my past 00/36 patch series, applied on
> > the top of docs tree (next branch).
> > 
> > The full patch series is on this tree is at:
> > 
> >    https://git.linuxtv.org//mchehab/experimental.git/log/?h=docbook
> > 
> > And the HTML output at:
> > 
> >   http://www.infradead.org/~mchehab/kernel_docs/
> >   https://mchehab.fedorapeople.org/kernel_docs/ 
> > 
> > Mauro Carvalho Chehab (5):
> >   docs-rst: convert librs book to ReST
> >   docs-rst: convert mtdnand book to ReST
> >   mtdnand.rst: Fix some typos and group the "::" with previous line  
> 
> MTD maintainers did not receive the above patch. Can you Cc us the
> whole series next time.

Sorry. I'll add you on the whole series. It will be a big one, though,
as it will contain the other docbook conversions on it (~50+ patches).

> BTW, I had a look at your branch and it seems the typo you're fixing is
> actually not a type. Flags are *OR-ed* (with the | operator) to form a
> valid combination of flags.

Ah! Ok, I updated the patch (see enclosed). Would that be OK for you?

> >   mtd: adjust kernel-docs to avoid Sphinx/kerneldoc warnings  
> 
> Not sure how you plan to merge these changes, but if it goes through
> a single tree I'll probably need an immutable topic branch, because I
> plan to change a few things in nand_base.c nand.h for the next release.

At least the patches that touch at Documentation/* should go, IMHO,
via a single tree:
	git://git.lwn.net/linux.git docs-next

As Jon mentioned, he doesn't rebase it, so you should be able to get an
immutable branch from it.


Thanks,
Mauro

---

[PATCH] mtdnand.rst: group the "::" with previous line

Group the :: with the previous paragraph, in order to make it
visually better when reading as a text file.

While here, replace:
	ored (with means "Covered or adorned with ore or metal")
by:
	OR-ed

To reflect its true meaning.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
index 8723175f955e..7c19795ebb4a 100644
--- a/Documentation/driver-api/mtdnand.rst
+++ b/Documentation/driver-api/mtdnand.rst
@@ -843,10 +843,8 @@ Chip option constants
 Constants for chip id table
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-These constants are defined in nand.h. They are ored together to
-describe the chip functionality.
-
-::
+These constants are defined in nand.h. They are OR-ed together to
+describe the chip functionality::
 
     /* Buswitdh is 16 bit */
     #define NAND_BUSWIDTH_16    0x00000002
@@ -867,10 +865,8 @@ describe the chip functionality.
 Constants for runtime options
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-These constants are defined in nand.h. They are ored together to
-describe the functionality.
-
-::
+These constants are defined in nand.h. They are OR-ed together to
+describe the functionality::
 
     /* The hw ecc generator provides a syndrome instead a ecc value on read
      * This can only work if we have the ecc bytes directly behind the
@@ -881,9 +877,7 @@ describe the functionality.
 ECC selection constants
 -----------------------
 
-Use these constants to select the ECC algorithm.
-
-::
+Use these constants to select the ECC algorithm::
 
     /* No ECC. Usage is not recommended ! */
     #define NAND_ECC_NONE       0
@@ -903,9 +897,7 @@ Hardware control related constants
 ----------------------------------
 
 These constants describe the requested hardware access function when the
-boardspecific hardware control function is called
-
-::
+boardspecific hardware control function is called::
 
     /* Select the chip by setting nCE to low */
     #define NAND_CTL_SETNCE     1
@@ -929,9 +921,7 @@ Bad block table related constants
 ---------------------------------
 
 These constants describe the options used for bad block table
-descriptors.
-
-::
+descriptors::
 
     /* Options for the bad block table descriptors */
 


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
