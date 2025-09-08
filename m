Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77522422D
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329116; cv=none; b=iDpxoeqTsbm3Q3LuafAZvdpcX0udpon1rWCr/D94G77nEUkeXjMFdWM9TNLrBzsh3RrXZsUaZinogF+tFcog1epLrpLBJ/3zQ5cmpx1HZBMufyfdV0U7JIrI7I4hBNUbAHg6GhKIcmQwuP1dgnU2mXXNUXaz59Q5GHvZJ0/sBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329116; c=relaxed/simple;
	bh=G44EIqcHlPc0MPwbyXEzw8SRNF12eQUABiDDCqEXD9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VSpLadaodfPltxzkWFT+v43ZOC273uVp+vgAGvbUZqWY7yE7vwAlp7kVdI+SAy6TuRZb0pH7S4IZvWtcI6nmqBCTxmdfrJmxjB1NFo40vwip+qon7iiHZ2YoZgPW6kXE3ZsYhb5CybKayN3HwmBgRLzm4gQYjcK12MSkXVjZQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlOJ2uwn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlOJ2uwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757329113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myamu423IxjnsnsnK8n7lFRHcKeofu6ER79sc7yqpzA=;
	b=VlOJ2uwn2zwrq9rtr6JRJTooSmxAlEAFRkB3f/Enb5hHH7BmQwBQvEXgi+WgRqkZPI4itG
	VbbBxWmR4T2+1nAlC9tCXlRMtwz6PW7nYhJHeOHJNTb8v1PBUzzVMdTThszYLJo61DGpBx
	5m+LRSQUKaItvtCBxqGxIeaV1f6+qeo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-8Duw3vvgN9aS2fZ1BOXSog-1; Mon, 08 Sep 2025 06:58:30 -0400
X-MC-Unique: 8Duw3vvgN9aS2fZ1BOXSog-1
X-Mimecast-MFC-AGG-ID: 8Duw3vvgN9aS2fZ1BOXSog_1757329109
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4e63a34f3fso3214294a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 03:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329109; x=1757933909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myamu423IxjnsnsnK8n7lFRHcKeofu6ER79sc7yqpzA=;
        b=ggoC6oQHQigPWOOvMOZWtmdPeeWJKBn07ZWUFSS7Np0ySM6eZviYFKe7BVoDIN0nhl
         K7C01e7leVrPBcxS2V9z+2koq1OpVCrLyYxDepF4I+0QzKr75B1tE+4RDzsvFDdtq/Fw
         LoFXYWKgMvey32ns8XTYOwZ6QzzuMGpJP8xTU/lT1GEKoiHiwuTihhS4hu0LpiK4sScC
         0lOcLmsWdiN8E//LaozjoIF1Nu9R960V1GDg7Etk3fXhzIKTrRCuLwZEkZRPZLcQZdf/
         B1GMYyC1+oF+YWaiNAQw6ZVOmpN3Azk2gJBPyyDJw6PpPsYvcSb3ybx/ezcZdWjhRYT5
         B/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCURSL0g+ZGoeLYvyP4IQQ05s4KKcW+++FL3UDzAYhvX9GeBgisZwlxJbJCFUZhhBPPcdhzOKNaP7MNrvST4t5pWQA6uxCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUby1NfvjqOA9qcGmQ8JSN6tPWd6xpdNOkodZyokkqc8jOCV0
	fjeKS5+DjJzvtbdPN0XypkSLy1t4Qzp7JxeonVCEmr1qEWBCLZ7Mbbahm/PO611A80IzieOZySX
	oOph7aiFrljBjEem4aB2/8d9RV9E33uT3oO6wP0bblONKM3a3kUmDPS8Jv92XAQOHnmo/KP3eU9
	ctdQ==
X-Gm-Gg: ASbGncumhxBr7x493ClsSNYiys0t5+FK39DtdlvmzBgnIpXmGas9V94kA/4jstQvX0q
	S/ZFVPgEJiysSM081zowdybWhOo19cpdZb9f+BZlGBMWy5oXL3oKUmmd7QqC/1qWg4T0tTQ1Mdd
	MdXcgBekSmCBcLef784dKNCKPKQahZH7L/547CTzxgBHWRQSWtwYZ8hULs+NUXqs4iz5iV4+O/1
	MarKGWApyEqi9C1zq+CMusBo9bJgU0lhaUGMWd+agBQs8K0ze4apatcUDV6gyHjKk8dY73hnycQ
	RZbsks2841IUzis7j1OMNtekc35+6b4=
X-Received: by 2002:a05:6a20:430b:b0:243:ce0f:e809 with SMTP id adf61e73a8af0-2533e94f9b6mr10495780637.23.1757329109187;
        Mon, 08 Sep 2025 03:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4DVeHGcV8BCDHrKD5vIE00IOinovx4zFRGm8WoZlYfoY+Z0xsXFPf2zD23vpJ0Ng5ZtHbYw==
X-Received: by 2002:a05:6a20:430b:b0:243:ce0f:e809 with SMTP id adf61e73a8af0-2533e94f9b6mr10495760637.23.1757329108797;
        Mon, 08 Sep 2025 03:58:28 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd092e2aasm25702026a12.21.2025.09.08.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:58:28 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ima: don't clear IMA_DIGSIG flag when setting non-IMA xattr
Date: Mon,  8 Sep 2025 18:58:24 +0800
Message-ID: <20250908105825.1573222-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902042515.759750-1-coxu@redhat.com>
References: <20250902042515.759750-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o0ynghKcGGmqhe9EckDwJz1RS599FulGxWeZ20Ea6F4_1757329109
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently when both IMA and EVM are in fix mode, the IMA signature will
be reset to IMA hash if a program first stores IMA signature in
security.ima and then sets security.selinux for a file. For example, on
Fedora, after booting the kernel with "ima_appraise=fix evm=fix
ima_policy=appraise_tcb" and installing rpm-plugin-ima, reinstalling a
package will not make good reference IMA signature generated. Instead
IMA hash is generated,
    # getfattr -m - -d -e hex /usr/bin/bash
    # file: usr/bin/bash
    security.ima=0x0404...

This happens because when setting selinux.selinux, the IMA_DIGSIG flag
that had been set early was cleared. As a result, IMA hash is generated
when the file is closed.

Here's a minimal C reproducer,

    #include <stdio.h>
    #include <sys/xattr.h>
    #include <fcntl.h>
    #include <unistd.h>
    #include <string.h>
    #include <stdlib.h>

    int main() {
        const char* file_path = "/usr/sbin/test_binary";
        const char* hex_string = "030204d33204490066306402304";
        int length = strlen(hex_string);
        char* ima_attr_value;
        int fd;

        fd = open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
        if (fd == -1) {
            perror("Error opening file");
            return 1;
        }

        ima_attr_value = (char*)malloc(length / 2 );
        for (int i = 0, j = 0; i < length; i += 2, j++) {
            sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
        }

        if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) == -1) {
            perror("Error setting extended attribute");
            close(fd);
            return 1;
        }

        const char* selinux_value= "system_u:object_r:bin_t:s0";
        if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selinux_value), 0) == -1) {
            perror("Error setting extended attribute");
            close(fd);
            return 1;
        }

        close(fd);

        return 0;
    }

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..4e4750ea41ad 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -694,6 +694,15 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	return 0;
 }
 
+/*
+ * ima_reset_appraise_flags - reset ima_iint_cache flags
+ *
+ * @digsig: whether to clear/set IMA_DIGSIG flag, tristate values
+ *          0: clear IMA_DIGSIG
+ *          1: set IMA_DIGSIG
+ *         -1: don't change IMA_DIGSIG
+ *
+ */
 static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 {
 	struct ima_iint_cache *iint;
@@ -706,9 +715,9 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 		return;
 	iint->measured_pcrs = 0;
 	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
-	if (digsig)
+	if (digsig == 1)
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-	else
+	else if (digsig == 0)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
 
@@ -794,6 +803,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
 	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
+	} else {
+		digsig = -1;
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
-- 
2.51.0

