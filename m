Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E401C64E7A
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 17:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5083B248AD
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 17:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KcntOEJ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lip4ZlRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgKRRTR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:19:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56246 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgKRRSZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:25 -0500
Date:   Wed, 18 Nov 2020 17:18:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wECg+8uZGshWYgucJSx2+BRGk0x3qRttXmutAz+ekIc=;
        b=KcntOEJ5nUHEbE/y5XWjGXt8EVPvqHc7fLW0WMrjRtkS7kN2BQJKAxGvo1vC3hGkmdoX+6
        h5tdsYfyYvLmWMOEpBz2S2u42cGzskmg6YAauTs01BgFu/9JCltyUB90XdWQH3ev/sA2wP
        zsIXGfO7jTCd5MP/mTrfSK2W+GHOZTMfsJPJzo+fhfTbBkPgIpkZvRhJftApfqRSZWHuhV
        WmA1N1045f6PjNd86cbmrflubEz7Mm6ROX26DXnBy1zfWBGPRYkq6xBlJmOaBxrtrpbFAB
        FzMJNk6Y/O0YI5WHcAYQ7BT8qZCc2pTj97W9QnoNVPhFAvQ0+/5n9Y1J1h4fMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wECg+8uZGshWYgucJSx2+BRGk0x3qRttXmutAz+ekIc=;
        b=lip4ZlRcXvQMac2hJAIb+VQC4SOSxniR+f0z2OHDaoZ6vEzaw5FCVMwFJ6vVneDdwHnQoW
        MT5xosoDCvK6/9AA==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add SGX_IOC_ENCLAVE_PROVISION
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-16-jarkko@kernel.org>
References: <20201112220135.165028-16-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990174.11244.8472802756523040645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     c82c61865024b9981f00358433bebed92ca20c00
Gitweb:        https://git.kernel.org/tip/c82c61865024b9981f00358433bebed92ca=
20c00
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:02:50 +01:00

x86/sgx: Add SGX_IOC_ENCLAVE_PROVISION

The whole point of SGX is to create a hardware protected place to do
=E2=80=9Cstuff=E2=80=9D. But, before someone is willing to hand over the keys=
 to
the castle , an enclave must often prove that it is running on an
SGX-protected processor. Provisioning enclaves play a key role in
providing proof.

There are actually three different enclaves in play in order to make this
happen:

1. The application enclave.  The familiar one we know and love that runs
   the actual code that=E2=80=99s doing real work.  There can be many of thes=
e on
   a single system, or even in a single application.
2. The quoting enclave  (QE).  The QE is mentioned in lots of silly
   whitepapers, but, for the purposes of kernel enabling, just pretend they
   do not exist.
3. The provisioning enclave.  There is typically only one of these
   enclaves per system.  Provisioning enclaves have access to a special
   hardware key.

   They can use this key to help to generate certificates which serve as
   proof that enclaves are running on trusted SGX hardware.  These
   certificates can be passed around without revealing the special key.

Any user who can create a provisioning enclave can access the
processor-unique Provisioning Certificate Key which has privacy and
fingerprinting implications. Even if a user is permitted to create
normal application enclaves (via /dev/sgx_enclave), they should not be
able to create provisioning enclaves. That means a separate permissions
scheme is needed to control provisioning enclave privileges.

Implement a separate device file (/dev/sgx_provision) which allows
creating provisioning enclaves. This device will typically have more
strict permissions than the plain enclave device.

The actual device =E2=80=9Cdriver=E2=80=9D is an empty stub.  Open file descr=
iptors for
this device will represent a token which allows provisioning enclave duty.
This file descriptor can be passed around and ultimately given as an
argument to the /dev/sgx_enclave driver ioctl().

 [ bp: Touchups. ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-security-module@vger.kernel.org
Link: https://lkml.kernel.org/r/20201112220135.165028-16-jarkko@kernel.org
---
 arch/x86/include/uapi/asm/sgx.h  | 11 +++++++++-
 arch/x86/kernel/cpu/sgx/driver.c | 24 +++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/driver.h |  2 ++-
 arch/x86/kernel/cpu/sgx/ioctl.c  | 37 +++++++++++++++++++++++++++++++-
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 66f2d32..c322102 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -25,6 +25,8 @@ enum sgx_page_flags {
 	_IOWR(SGX_MAGIC, 0x01, struct sgx_enclave_add_pages)
 #define SGX_IOC_ENCLAVE_INIT \
 	_IOW(SGX_MAGIC, 0x02, struct sgx_enclave_init)
+#define SGX_IOC_ENCLAVE_PROVISION \
+	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
=20
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -63,4 +65,13 @@ struct sgx_enclave_init {
 	__u64 sigstruct;
 };
=20
+/**
+ * struct sgx_enclave_provision - parameter structure for the
+ *				  %SGX_IOC_ENCLAVE_PROVISION ioctl
+ * @fd:		file handle of /dev/sgx_provision
+ */
+struct sgx_enclave_provision {
+	__u64 fd;
+};
+
 #endif /* _UAPI_ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/drive=
r.c
index bf5c4a3..899c184 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -112,6 +112,10 @@ static const struct file_operations sgx_encl_fops =3D {
 	.get_unmapped_area	=3D sgx_get_unmapped_area,
 };
=20
+const struct file_operations sgx_provision_fops =3D {
+	.owner			=3D THIS_MODULE,
+};
+
 static struct miscdevice sgx_dev_enclave =3D {
 	.minor =3D MISC_DYNAMIC_MINOR,
 	.name =3D "sgx_enclave",
@@ -119,11 +123,19 @@ static struct miscdevice sgx_dev_enclave =3D {
 	.fops =3D &sgx_encl_fops,
 };
=20
+static struct miscdevice sgx_dev_provision =3D {
+	.minor =3D MISC_DYNAMIC_MINOR,
+	.name =3D "sgx_provision",
+	.nodename =3D "sgx_provision",
+	.fops =3D &sgx_provision_fops,
+};
+
 int __init sgx_drv_init(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	u64 attr_mask;
 	u64 xfrm_mask;
+	int ret;
=20
 	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
 		return -ENODEV;
@@ -147,5 +159,15 @@ int __init sgx_drv_init(void)
 		sgx_xfrm_reserved_mask =3D ~xfrm_mask;
 	}
=20
-	return misc_register(&sgx_dev_enclave);
+	ret =3D misc_register(&sgx_dev_enclave);
+	if (ret)
+		return ret;
+
+	ret =3D misc_register(&sgx_dev_provision);
+	if (ret) {
+		misc_deregister(&sgx_dev_enclave);
+		return ret;
+	}
+
+	return 0;
 }
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/drive=
r.h
index 6b00632..4eddb4d 100644
--- a/arch/x86/kernel/cpu/sgx/driver.h
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -20,6 +20,8 @@ extern u64 sgx_attributes_reserved_mask;
 extern u64 sgx_xfrm_reserved_mask;
 extern u32 sgx_misc_reserved_mask;
=20
+extern const struct file_operations sgx_provision_fops;
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
=20
 int sgx_drv_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index e036819..0ba0e67 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -569,6 +569,40 @@ out:
 	return ret;
 }
=20
+/**
+ * sgx_ioc_enclave_provision() - handler for %SGX_IOC_ENCLAVE_PROVISION
+ * @enclave:	an enclave pointer
+ * @arg:	userspace pointer to a struct sgx_enclave_provision instance
+ *
+ * Allow ATTRIBUTE.PROVISION_KEY for an enclave by providing a file handle to
+ * /dev/sgx_provision.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -errno:	Otherwise.
+ */
+static long sgx_ioc_enclave_provision(struct sgx_encl *encl, void __user *ar=
g)
+{
+	struct sgx_enclave_provision params;
+	struct file *file;
+
+	if (copy_from_user(&params, arg, sizeof(params)))
+		return -EFAULT;
+
+	file =3D fget(params.fd);
+	if (!file)
+		return -EINVAL;
+
+	if (file->f_op !=3D &sgx_provision_fops) {
+		fput(file);
+		return -EINVAL;
+	}
+
+	encl->attributes_mask |=3D SGX_ATTR_PROVISIONKEY;
+
+	fput(file);
+	return 0;
+}
=20
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
@@ -588,6 +622,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsi=
gned long arg)
 	case SGX_IOC_ENCLAVE_INIT:
 		ret =3D sgx_ioc_enclave_init(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_PROVISION:
+		ret =3D sgx_ioc_enclave_provision(encl, (void __user *)arg);
+		break;
 	default:
 		ret =3D -ENOIOCTLCMD;
 		break;
