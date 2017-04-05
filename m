From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 18:01:10 +0100
Subject: [PATCH 29/38] Annotate hardware config module parameters in
	drivers/staging/speakup/
In-Reply-To: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
Message-ID: <149141167058.29162.7142804081158375419.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in drivers/staging/speakup/.

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: speakup at linux-speakup.org
cc: devel at driverdev.osuosl.org
---

 drivers/staging/speakup/speakup_acntpc.c |    2 +-
 drivers/staging/speakup/speakup_dtlk.c   |    2 +-
 drivers/staging/speakup/speakup_keypc.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/speakup/speakup_acntpc.c b/drivers/staging/speakup/speakup_acntpc.c
index c7fab261d860..b6fbf9de1f85 100644
--- a/drivers/staging/speakup/speakup_acntpc.c
+++ b/drivers/staging/speakup/speakup_acntpc.c
@@ -307,7 +307,7 @@ static void accent_release(void)
 	speakup_info.port_tts = 0;
 }
 
-module_param_named(port, port_forced, int, 0444);
+module_param_hw_named(port, port_forced, int, ioport, 0444);
 module_param_named(start, synth_acntpc.startup, short, 0444);
 
 MODULE_PARM_DESC(port, "Set the port for the synthesizer (override probing).");
diff --git a/drivers/staging/speakup/speakup_dtlk.c b/drivers/staging/speakup/speakup_dtlk.c
index e2bf20806d8d..9c097fda07b0 100644
--- a/drivers/staging/speakup/speakup_dtlk.c
+++ b/drivers/staging/speakup/speakup_dtlk.c
@@ -378,7 +378,7 @@ static void dtlk_release(void)
 	speakup_info.port_tts = 0;
 }
 
-module_param_named(port, port_forced, int, 0444);
+module_param_hw_named(port, port_forced, int, ioport, 0444);
 module_param_named(start, synth_dtlk.startup, short, 0444);
 
 MODULE_PARM_DESC(port, "Set the port for the synthesizer (override probing).");
diff --git a/drivers/staging/speakup/speakup_keypc.c b/drivers/staging/speakup/speakup_keypc.c
index 10f4964782e2..e653b52175b8 100644
--- a/drivers/staging/speakup/speakup_keypc.c
+++ b/drivers/staging/speakup/speakup_keypc.c
@@ -309,7 +309,7 @@ static void keynote_release(void)
 	synth_port = 0;
 }
 
-module_param_named(port, port_forced, int, 0444);
+module_param_hw_named(port, port_forced, int, ioport, 0444);
 module_param_named(start, synth_keypc.startup, short, 0444);
 
 MODULE_PARM_DESC(port, "Set the port for the synthesizer (override probing).");

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
