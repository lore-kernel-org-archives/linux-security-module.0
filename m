Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA0387591;
	Fri, 27 Feb 2026 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235607; cv=none; b=u2k03UOhNQma+5vUVYJXffShTAzZZvuhmW922SyGiDXBDvTvGmQIveQ1hnn+KFwMk7RcsSs5+/n/NyLYFxU8h8mZ77gFMPYrZQEB2J45GfN9TPNeGfS4BM4+dvVrxGJ7OnOEie7zKTd1NfLNQCcgQVPsjjU/yWiSsVR+vmDSNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235607; c=relaxed/simple;
	bh=+dTEJzFojVGkMjmQpBEQWSGyeLmu8TyKLBEW/ep/xtA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGk98HI3AfepNVTcmEYr46Yz4lt0yRPR1JoQ6ZAzmFSB/axUCOMxLqlGEPmBJdigSIsEbu0T8M/rzBtn+3RhGNK6atI/QeleuBFKcrwZq/Rb/p9eMTRoOcReZqs+0J8oSP8JILnl9kGtC2rSVlgtqPLLBvRqy7OFUUDfHrhAx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=slx7gptm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="slx7gptm"
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id E404E20B6F04;
	Fri, 27 Feb 2026 15:39:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E404E20B6F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772235597;
	bh=i9twvq8JrtL59RC3H2y98NvkktxcKnroS4QUjvi8r6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=slx7gptm5LyMr2hkBLgat6R6pjzYYdgi6ryoiOFtJWG2hdKcNTeBG5KCYWY28UcWu
	 7RKQujqMAA1b+wai1HYWpWTJ6X1NIzFNhOUTCqDlmVQZ+aJHKRQ9tYnEIeTXvDD3jm
	 MrVyGnpGlfnRQut2eemEF1HVbL3hAcy8of1EciSg=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 07/10] security: Hornet LSM
Date: Fri, 27 Feb 2026 15:38:36 -0800
Message-ID: <20260227233930.2418522-8-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
References: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the Hornet Linux Security Module which provides enhanced
signature verification and data validation for eBPF programs. This
allows users to continue to maintain an invariant that all code
running inside of the kernel has actually been signed and verified, by
the kernel.

This effort builds upon the currently excepted upstream solution. It
further hardens it by providing deterministic, in-kernel checking of
map hashes to solidify auditing along with preventing TOCTOU attacks
against lskel map hashes.

Target map hashes are passed in via PKCS#7 signed attributes. Hornet
determines the extent which the eBFP program is signed and defers to
other LSMs for policy decisions.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
---
 Documentation/admin-guide/LSM/Hornet.rst | 310 ++++++++++++++++++++++
 Documentation/admin-guide/LSM/index.rst  |   1 +
 MAINTAINERS                              |   9 +
 include/linux/oid_registry.h             |   3 +
 include/uapi/linux/lsm.h                 |   1 +
 security/Kconfig                         |   3 +-
 security/Makefile                        |   1 +
 security/hornet/Kconfig                  |  11 +
 security/hornet/Makefile                 |   7 +
 security/hornet/hornet.asn1              |  13 +
 security/hornet/hornet_lsm.c             | 323 +++++++++++++++++++++++
 11 files changed, 681 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
 create mode 100644 security/hornet/Kconfig
 create mode 100644 security/hornet/Makefile
 create mode 100644 security/hornet/hornet.asn1
 create mode 100644 security/hornet/hornet_lsm.c

diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
new file mode 100644
index 000000000000..0dd4c03b8a7e
--- /dev/null
+++ b/Documentation/admin-guide/LSM/Hornet.rst
@@ -0,0 +1,310 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+Hornet
+======
+
+Hornet is a Linux Security Module that provides extensible signature
+verification for eBPF programs. This is selectable at build-time with
+``CONFIG_SECURITY_HORNET``.
+
+Overview
+========
+
+Hornet addresses concerns from users who require strict audit trails and
+verification guarantees for eBPF programs, especially in
+security-sensitive environments. Many production systems need assurance
+that only authorized, unmodified eBPF programs are loaded into the
+kernel. Hornet provides this assurance through cryptographic signature
+verification.
+
+When an eBPF program is loaded via the ``bpf()`` syscall, Hornet
+verifies a PKCS#7 signature attached to the program instructions. The
+signature is checked against the kernel's secondary keyring using the
+existing kernel cryptographic infrastructure. In addition to signing the
+program bytecode, Hornet supports signing SHA-256 hashes of associated
+BPF maps, enabling integrity verification of map contents at load time
+and at runtime.
+
+After verification, Hornet classifies the program into one of the
+following integrity states and passes the result to a downstream LSM hook
+(``bpf_prog_load_post_integrity``), allowing other security modules to
+make policy decisions based on the verification outcome:
+
+``LSM_INT_VERDICT_OK``
+  The program signature and all map hashes verified successfully.
+
+``LSM_INT_VERDICT_UNSIGNED``
+  No signature was provided with the program.
+
+``LSM_INT_VERDICT_PARTIALSIG``
+  The program signature verified, but the signing certificate is not
+  trusted in the secondary keyring, or the signature did not contain
+  hornet map hash data.
+
+``LSM_INT_VERDICT_BADSIG``
+  The signature or a map hash failed verification.
+
+Hornet itself does not enforce a policy on whether unsigned or partially
+signed programs should be rejected. It delegates that decision to
+downstream LSMs via the ``bpf_prog_load_post_integrity`` hook, making it
+a composable building block in a larger security architecture.
+
+Use Cases
+=========
+
+- **Locked-down production environments**: Ensure only eBPF programs
+  signed by a trusted authority can be loaded, preventing unauthorized
+  or tampered programs from running in the kernel.
+
+- **Audit and compliance**: Provide cryptographic evidence that loaded
+  eBPF programs match their expected build artifacts, supporting
+  compliance requirements in regulated industries.
+
+- **Supply chain integrity**: Verify that eBPF programs and their
+  associated map data have not been modified since they were built and
+  signed, protecting against supply chain attacks.
+
+Threat Model
+============
+
+Hornet protects against the following threats:
+
+- **Unauthorized eBPF program loading**: Programs that have not been
+  signed by a trusted key will be reported as unsigned or badly signed.
+
+- **Tampering with program instructions**: Any modification to the eBPF
+  bytecode after signing will cause signature verification to fail.
+
+- **Tampering with map data**: When map hashes are included in the
+  signature, Hornet verifies that frozen BPF maps match their expected
+  SHA-256 hashes at load time. Maps are also re-verified before program
+  execution via ``BPF_PROG_RUN``.
+
+Hornet does **not** protect against:
+
+- Compromise of the signing key itself.
+- Attacks that occur after a program has been loaded and verified.
+- Programs loaded by the kernel itself (kernel-internal loads bypass
+  the ``BPF_PROG_RUN`` map check).
+
+Known Limitations
+=================
+
+- Hornet requires programs to use :doc:`light skeletons
+  </bpf/libbpf/libbpf_naming_convention>` (lskels) for the signing
+  workflow, as the tooling operates on lskel-generated headers.
+
+- A maximum of 64 maps per program can be tracked for hash
+  verification.
+
+- Map hash verification requires the maps to be frozen before loading.
+  Maps that are not frozen at load time will cause verification to fail
+  when their hashes are included in the signature.
+
+- Hornet relies on the kernel's secondary keyring
+  (``VERIFY_USE_SECONDARY_KEYRING``) for certificate trust. Keys must
+  be provisioned into this keyring before programs can be verified.
+
+Configuration
+=============
+
+Build Configuration
+-------------------
+
+Enable Hornet by setting the following kernel configuration option::
+
+  CONFIG_SECURITY_HORNET=y
+
+This option is found under :menuselection:`Security options --> Hornet
+support` and depends on ``CONFIG_SECURITY``.
+
+When enabled, Hornet is included in the default LSM initialization order
+and will appear in ``/sys/kernel/security/lsm``.
+
+Architecture
+============
+
+Signature Verification Flow
+---------------------------
+
+The following describes what happens when a userspace program calls
+``bpf(BPF_PROG_LOAD, ...)`` with a signature attached:
+
+1. The ``bpf_prog_load_integrity`` LSM hook is invoked.
+
+2. Hornet reads the signature from the userspace buffer specified by
+   ``attr->signature`` (with length ``attr->signature_size``).
+
+3. The PKCS#7 signature is verified against the program instructions
+   using ``verify_pkcs7_signature()`` with the kernel's secondary
+   keyring.
+
+4. The PKCS#7 message is parsed and its trust chain is validated via
+   ``validate_pkcs7_trust()``.
+
+5. Hornet extracts the authenticated attribute identified by
+   ``OID_hornet_data`` (OID ``2.25.316487325684022475439036912669789383960``)
+   from the PKCS#7 message. This attribute contains an ASN.1-encoded set
+   of map index/hash pairs.
+
+6. For each map hash entry, Hornet retrieves the corresponding BPF map
+   via its file descriptor, confirms it is frozen, computes its SHA-256
+   hash, and compares it against the signed hash.
+
+7. The resulting integrity verdict is passed to the
+   ``bpf_prog_load_post_integrity`` hook so that downstream LSMs can
+   enforce policy.
+
+Runtime Map Verification
+------------------------
+
+When ``bpf(BPF_PROG_RUN, ...)`` is called from userspace, Hornet
+re-verifies the hashes of all maps associated with the program. This
+ensures that map contents have not been modified between program load
+and execution. If any map hash no longer matches, the ``BPF_PROG_RUN``
+command is denied.
+
+Userspace Interface
+-------------------
+
+Signatures are passed to the kernel through fields in ``union bpf_attr``
+when using the ``BPF_PROG_LOAD`` command:
+
+``signature``
+  A pointer to a userspace buffer containing the PKCS#7 signature.
+
+``signature_size``
+  The size of the signature buffer in bytes.
+
+ASN.1 Schema
+------------
+
+Map hashes are encoded as a signed attribute in the PKCS#7 message using
+the following ASN.1 schema::
+
+  HornetData ::= SET OF Map
+
+  Map ::= SEQUENCE {
+      index   INTEGER,
+      sha     OCTET STRING
+  }
+
+Each ``Map`` entry contains the index of the map in the program's
+``fd_array`` and its expected SHA-256 hash. A zero-length ``sha`` field
+indicates that the map at that index should be skipped during
+verification.
+
+Tooling
+=======
+
+Helper scripts and a signature generation tool are provided in
+``scripts/hornet/`` to support the development of signed eBPF light
+skeletons.
+
+gen_sig
+-------
+
+``gen_sig`` is a C program (using OpenSSL) that creates a PKCS#7
+signature over eBPF program instructions and optionally includes
+SHA-256 hashes of BPF maps as signed attributes.
+
+Usage::
+
+  gen_sig --data <instructions.bin> \
+          --cert <signer.crt> \
+          --key <signer.key> \
+          [--pass <passphrase>] \
+          --out <signature.p7b> \
+          [--add <mapfile.bin>:<index> ...]
+
+``--data``
+  Path to the binary file containing eBPF program instructions to sign.
+
+``--cert``
+  Path to the signing certificate (PEM or DER format).
+
+``--key``
+  Path to the private key (PEM or DER format).
+
+``--pass``
+  Optional passphrase for the private key.
+
+``--out``
+  Path to write the output PKCS#7 signature.
+
+``--add``
+  Attach a map hash as a signed attribute. The argument is a path to a
+  binary map file followed by a colon and the map's index in the
+  ``fd_array``. This option may be specified multiple times.
+
+extract-skel.sh
+---------------
+
+Extracts a named field from an autogenerated eBPF lskel header file.
+Used internally by other helper scripts.
+
+extract-insn.sh
+---------------
+
+Extracts the eBPF program instructions (``opts_insn``) from an lskel
+header into a binary file suitable for signing with ``gen_sig``.
+
+extract-map.sh
+--------------
+
+Extracts the map data (``opts_data``) from an lskel header into a
+binary file suitable for hashing with ``gen_sig``.
+
+write-sig.sh
+------------
+
+Replaces the signature data in an lskel header with a new signature
+from a binary file. This is used to embed a freshly generated signature
+back into the header after signing.
+
+Signing Workflow
+================
+
+A typical workflow for building and signing an eBPF light skeleton is:
+
+1. **Compile the eBPF program**::
+
+     clang -O2 -target bpf -c program.bpf.c -o program.bpf.o
+
+2. **Generate the light skeleton header** using ``bpftool``::
+
+     bpftool gen skeleton -S program.bpf.o > loader.h
+
+3. **Extract instructions and map data** from the generated header::
+
+     scripts/hornet/extract-insn.sh loader.h > insn.bin
+     scripts/hornet/extract-map.sh loader.h > map.bin
+
+4. **Generate the signature** with ``gen_sig``::
+
+     scripts/hornet/gen_sig \
+       --key signing_key.pem \
+       --cert signing_key.x509 \
+       --data insn.bin \
+       --add map.bin:0 \
+       --out sig.bin
+
+5. **Embed the signature** back into the header::
+
+     scripts/hornet/write-sig.sh loader.h sig.bin > signed_loader.h
+
+6. **Build the loader program** using the signed header::
+
+     cc -o loader loader.c -lbpf
+
+The resulting loader program will pass the embedded signature to the
+kernel when loading the eBPF program, enabling Hornet to verify it.
+
+Testing
+=======
+
+Self-tests are provided in ``tools/testing/selftests/hornet/``. The test
+suite builds a minimal eBPF program (``trivial.bpf.c``), signs it using
+the workflow described above, and verifies that the signed program loads
+successfully.
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index b44ef68f6e4d..57f6e9fbe5fd 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -49,3 +49,4 @@ subdirectories.
    SafeSetID
    ipe
    landlock
+   Hornet
diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..6e91234a9ba4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11682,6 +11682,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 F:	drivers/iio/pressure/mprls0025pa*
 
+HORNET SECURITY MODULE
+M:	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+T:	git https://github.com/blaiseboscaccy/hornet.git
+F:	Documentation/admin-guide/LSM/Hornet.rst
+F:	scripts/hornet/
+F:	security/hornet/
+
 HP BIOSCFG DRIVER
 M:	Jorge Lopez <jorge.lopez2@hp.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index ebce402854de..bf852715aaea 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -150,6 +150,9 @@ enum OID {
 	OID_id_ml_dsa_65,			/* 2.16.840.1.101.3.4.3.18 */
 	OID_id_ml_dsa_87,			/* 2.16.840.1.101.3.4.3.19 */
 
+	/* Hornet LSM */
+	OID_hornet_data,	  /* 2.25.316487325684022475439036912669789383960 */
+
 	OID__NR
 };
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..2ff9bcdd551e 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -65,6 +65,7 @@ struct lsm_ctx {
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
 #define LSM_ID_IPE		113
+#define LSM_ID_HORNET		114
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Kconfig b/security/Kconfig
index 6a4393fce9a1..283c4a103209 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -230,6 +230,7 @@ source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
 source "security/ipe/Kconfig"
+source "security/hornet/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -274,7 +275,7 @@ config LSM
 	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
 	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DEFAULT_SECURITY_TOMOYO
 	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,bpf"
+	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,hornet,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/Makefile b/security/Makefile
index 4601230ba442..b68cb56e419b 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
+obj-$(CONFIG_SECURITY_HORNET)		+= hornet/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
new file mode 100644
index 000000000000..19406aa237ac
--- /dev/null
+++ b/security/hornet/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SECURITY_HORNET
+	bool "Hornet support"
+	depends on SECURITY
+	default n
+	help
+	  This selects Hornet.
+	  Further information can be found in
+	  Documentation/admin-guide/LSM/Hornet.rst.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/hornet/Makefile b/security/hornet/Makefile
new file mode 100644
index 000000000000..26b6f954f762
--- /dev/null
+++ b/security/hornet/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SECURITY_HORNET) := hornet.o
+
+hornet-y := hornet.asn1.o \
+	hornet_lsm.o \
+
+$(obj)/hornet.asn1.o: $(obj)/hornet.asn1.c $(obj)/hornet.asn1.h
diff --git a/security/hornet/hornet.asn1 b/security/hornet/hornet.asn1
new file mode 100644
index 000000000000..c8d47b16b65d
--- /dev/null
+++ b/security/hornet/hornet.asn1
@@ -0,0 +1,13 @@
+-- SPDX-License-Identifier: BSD-3-Clause
+--
+-- Copyright (C) 2009 IETF Trust and the persons identified as authors
+-- of the code
+--
+-- https://www.rfc-editor.org/rfc/rfc5652#section-3
+
+HornetData ::= SET OF Map
+
+Map ::= SEQUENCE {
+	index			INTEGER ({ hornet_map_index }),
+	sha			OCTET STRING ({ hornet_map_hash })
+} ({ hornet_next_map })
diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
new file mode 100644
index 000000000000..6c821d6441fb
--- /dev/null
+++ b/security/hornet/hornet_lsm.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Hornet Linux Security Module
+ *
+ * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
+ *
+ * Copyright (C) 2026 Microsoft Corporation
+ */
+
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+#include <linux/bpf.h>
+#include <linux/verification.h>
+#include <crypto/public_key.h>
+#include <linux/module_signature.h>
+#include <crypto/pkcs7.h>
+#include <linux/sort.h>
+#include <linux/asn1_decoder.h>
+#include <linux/oid_registry.h>
+#include "hornet.asn1.h"
+
+#define MAX_USED_MAPS 64
+
+struct hornet_maps {
+	bpfptr_t fd_array;
+};
+
+struct hornet_parse_context {
+	int indexes[MAX_USED_MAPS];
+	bool skips[MAX_USED_MAPS];
+	unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
+	int hash_count;
+};
+
+struct hornet_prog_security_struct {
+	bool checked[MAX_USED_MAPS];
+	unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
+};
+
+struct hornet_map_security_struct {
+	bool checked;
+	int index;
+};
+
+struct lsm_blob_sizes hornet_blob_sizes __ro_after_init = {
+	.lbs_bpf_map = sizeof(struct hornet_map_security_struct),
+	.lbs_bpf_prog = sizeof(struct hornet_prog_security_struct),
+};
+
+static inline struct hornet_prog_security_struct *
+hornet_bpf_prog_security(struct bpf_prog *prog)
+{
+	return prog->aux->security + hornet_blob_sizes.lbs_bpf_prog;
+}
+
+static inline struct hornet_map_security_struct *
+hornet_bpf_map_security(struct bpf_map *map)
+{
+	return map->security + hornet_blob_sizes.lbs_bpf_map;
+}
+
+static int hornet_verify_hashes(struct hornet_maps *maps,
+				struct hornet_parse_context *ctx,
+				struct bpf_prog *prog)
+{
+	int map_fd;
+	u32 i;
+	struct bpf_map *map;
+	int err = 0;
+	unsigned char hash[SHA256_DIGEST_SIZE];
+	struct hornet_prog_security_struct *security = hornet_bpf_prog_security(prog);
+	struct hornet_map_security_struct *map_security;
+
+	for (i = 0; i < ctx->hash_count; i++) {
+		if (ctx->skips[i]) {
+			security->checked[i] = false;
+			continue;
+		}
+
+		err = copy_from_bpfptr_offset(&map_fd, maps->fd_array,
+					      ctx->indexes[i] * sizeof(map_fd),
+					      sizeof(map_fd));
+		if (err < 0)
+			return LSM_INT_VERDICT_BADSIG;
+
+		CLASS(fd, f)(map_fd);
+		if (fd_empty(f))
+			return LSM_INT_VERDICT_BADSIG;
+		if (unlikely(fd_file(f)->f_op != &bpf_map_fops))
+			return LSM_INT_VERDICT_BADSIG;
+
+		map = fd_file(f)->private_data;
+		if (!map->frozen)
+			return LSM_INT_VERDICT_BADSIG;
+
+		map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
+
+		err = memcmp(hash, &ctx->hashes[i * SHA256_DIGEST_SIZE],
+			      SHA256_DIGEST_SIZE);
+		if (err)
+			return LSM_INT_VERDICT_BADSIG;
+
+		security->checked[i] = true;
+		memcpy(&security->hashes[i * SHA256_DIGEST_SIZE], hash, SHA256_DIGEST_SIZE);
+		map_security = hornet_bpf_map_security(map);
+		map_security->checked = true;
+		map_security->index = i;
+	}
+	return LSM_INT_VERDICT_OK;
+}
+
+int hornet_next_map(void *context, size_t hdrlen,
+		     unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct hornet_parse_context *ctx = (struct hornet_parse_context *)context;
+
+	ctx->hash_count++;
+	return 0;
+}
+
+int hornet_map_index(void *context, size_t hdrlen,
+		     unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct hornet_parse_context *ctx = (struct hornet_parse_context *)context;
+
+	if (vlen > 1)
+		return -EINVAL;
+
+	ctx->indexes[ctx->hash_count] = *(u8 *)value;
+	return 0;
+}
+
+int hornet_map_hash(void *context, size_t hdrlen,
+		    unsigned char tag,
+		    const void *value, size_t vlen)
+
+{
+	struct hornet_parse_context *ctx = (struct hornet_parse_context *)context;
+
+	if (vlen != SHA256_DIGEST_SIZE && vlen != 0)
+		return -EINVAL;
+
+	if (vlen) {
+		ctx->skips[ctx->hash_count] = false;
+		memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE], value, vlen);
+	} else
+		ctx->skips[ctx->hash_count] = true;
+
+	return 0;
+}
+
+static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
+				struct bpf_token *token, bool is_kernel)
+{
+	struct hornet_maps maps = {0};
+	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
+	struct pkcs7_message *msg;
+	struct hornet_parse_context *ctx;
+	void *sig;
+	int err;
+	const void *authattrs;
+	size_t authattrs_len;
+
+	if (!attr->signature)
+		return LSM_INT_VERDICT_UNSIGNED;
+
+	ctx = kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	maps.fd_array = make_bpfptr(attr->fd_array, is_kernel);
+	sig = kzalloc(attr->signature_size, GFP_KERNEL);
+	if (!sig) {
+		err = -ENOMEM;
+		goto out;
+	}
+	err = copy_from_bpfptr(sig, usig, attr->signature_size);
+	if (err != 0)
+		goto cleanup_sig;
+
+	err = verify_pkcs7_signature(prog->insnsi, prog->len * sizeof(struct bpf_insn),
+				     sig, attr->signature_size, VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_BPF_SIGNATURE, NULL, NULL);
+	if (err < 0) {
+		err = LSM_INT_VERDICT_BADSIG;
+		goto cleanup_sig;
+	}
+
+	msg = pkcs7_parse_message(sig, attr->signature_size);
+	if (IS_ERR(msg)) {
+		err = LSM_INT_VERDICT_BADSIG;
+		goto cleanup_sig;
+	}
+
+	if (validate_pkcs7_trust(msg, VERIFY_USE_SECONDARY_KEYRING)) {
+		err = LSM_INT_VERDICT_PARTIALSIG;
+		goto cleanup_msg;
+	}
+	if (pkcs7_get_authattr(msg, OID_hornet_data,
+			       &authattrs, &authattrs_len) == -ENODATA) {
+		err = LSM_INT_VERDICT_PARTIALSIG;
+		goto cleanup_msg;
+	}
+
+	err = asn1_ber_decoder(&hornet_decoder, ctx, authattrs, authattrs_len);
+	if (err < 0 || authattrs == NULL) {
+		err = LSM_INT_VERDICT_PARTIALSIG;
+		goto cleanup_msg;
+	}
+	err = hornet_verify_hashes(&maps, ctx, prog);
+
+cleanup_msg:
+	pkcs7_free_message(msg);
+cleanup_sig:
+	kfree(sig);
+out:
+	kfree(ctx);
+	return err;
+}
+
+static const struct lsm_id hornet_lsmid = {
+	.name = "hornet",
+	.id = LSM_ID_HORNET,
+};
+
+static int hornet_bpf_prog_load_integrity(struct bpf_prog *prog, union bpf_attr *attr,
+					  struct bpf_token *token, bool is_kernel)
+{
+	int result = hornet_check_program(prog, attr, token, is_kernel);
+
+	if (result < 0)
+		return result;
+
+	return security_bpf_prog_load_post_integrity(prog, attr, token, is_kernel,
+						     &hornet_lsmid, result);
+}
+
+static int hornet_verify_map(struct bpf_prog *prog, int index)
+{
+	unsigned char hash[SHA256_DIGEST_SIZE];
+	int i;
+	struct bpf_map *map;
+	struct hornet_prog_security_struct *security = hornet_bpf_prog_security(prog);
+	struct hornet_map_security_struct *map_security;
+
+	if (!security->checked[index])
+		return 0;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		map_security = hornet_bpf_map_security(map);
+		if (map_security->index != index)
+			continue;
+
+		if (!map->frozen)
+			return -EINVAL;
+
+		map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
+		if (memcmp(hash, &security->hashes[index * SHA256_DIGEST_SIZE],
+			   SHA256_DIGEST_SIZE) != 0)
+			return -EINVAL;
+		else
+			return 0;
+	}
+	return -EINVAL;
+}
+
+static int hornet_check_prog_maps(u32 ufd)
+{
+	CLASS(fd, f)(ufd);
+	struct bpf_prog *prog;
+	int i, result = 0;
+
+	if (fd_empty(f))
+		return -EBADF;
+	if (fd_file(f)->f_op != &bpf_prog_fops)
+		return -EINVAL;
+
+	prog = fd_file(f)->private_data;
+
+	mutex_lock(&prog->aux->used_maps_mutex);
+	if (!prog->aux->used_map_cnt)
+		goto out;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		result = hornet_verify_map(prog, i);
+		if (result)
+			goto out;
+	}
+out:
+	mutex_unlock(&prog->aux->used_maps_mutex);
+	return result;
+}
+
+static int hornet_bpf(int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
+{
+	if (cmd != BPF_PROG_RUN)
+		return 0;
+	if (kernel)
+		return 0;
+
+	return hornet_check_prog_maps(attr->test.prog_fd);
+}
+
+static struct security_hook_list hornet_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(bpf_prog_load_integrity, hornet_bpf_prog_load_integrity),
+	LSM_HOOK_INIT(bpf, hornet_bpf),
+};
+
+static int __init hornet_init(void)
+{
+	pr_info("Hornet: eBPF signature verification enabled\n");
+	security_add_hooks(hornet_hooks, ARRAY_SIZE(hornet_hooks), &hornet_lsmid);
+	return 0;
+}
+
+DEFINE_LSM(hornet) = {
+	.id = &hornet_lsmid,
+	.blobs = &hornet_blob_sizes,
+	.init = hornet_init,
+};
-- 
2.52.0

