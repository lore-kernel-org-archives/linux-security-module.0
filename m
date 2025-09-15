Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C920E6E3
	for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915738; cv=none; b=QmrJOWBqGaB2lrSBruRJaVx+AvZFRFI6psQ3r9MoXYlwA8uZ1YFVT7bPY9upxd/IcvfBIw5doYPtD4LdO7isJkcFHjfbTP7yF5ySY7dzO6bZ24L66MQpMlTxQNMsf6Kw6NLcyCjbGdbrVaCPXoPB3PMaTWJzkLzFATE0OsuilEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915738; c=relaxed/simple;
	bh=DbYsO7UJQJRjzTAl4hsAi+uv5Z0ebRu1GjxF1gpkvJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=chIK5S2cruwMiJ9hL46XNRAHMk5dyAuOvA3jtEQPiT7JcciEG8DfQicRJXkpKkMG0uzge73d/hkbF5INlNe0kgjLpmZ0sniD+o0AQBFj08tSCwJmewBw1L42cUZnHVFcbzDFvjIGmZAXeygdfAGFxy3G56Pxv0UQ4t//Uk7PYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SK6xGXAv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SK6xGXAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757915735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgzCsQOKmacoCjP/GBUfHiLtpkuIZsT3t9XMSe2iV7U=;
	b=SK6xGXAvZ35odbpWfLO/tUrH4UkjZCS9zmWeMze0tk1vx3dEuN2xEW22TW1u61PwsQU3Kb
	8gjqEIaLpm9AGoGBTo67xCTMcsTRgFHhE1A7eNE55uoNKaKF+MoRoZl/znpQZrHVQtIMZM
	tFLL1UOh/O4dySepaDds1TU9WgEC+f4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685--Af2TMD1PUqLfk98HZ3gjA-1; Mon, 15 Sep 2025 01:55:34 -0400
X-MC-Unique: -Af2TMD1PUqLfk98HZ3gjA-1
X-Mimecast-MFC-AGG-ID: -Af2TMD1PUqLfk98HZ3gjA_1757915733
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54d0ffd172so350242a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 14 Sep 2025 22:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757915733; x=1758520533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgzCsQOKmacoCjP/GBUfHiLtpkuIZsT3t9XMSe2iV7U=;
        b=SEzOsLGc9UzojKgbGWv/FcFK0qUTj5JJa4BX8m+hYYxdcGEl3sDhVRmAfwedCIksNK
         cKlmAK3pMbpYneoBzOUAzJ8eCt/cmVUWL/asKCPKEsxqYtbfo/x4nCq4MYP6TUJ9kr3G
         +CsepToR1Hg63ZmYtB62jwAazBl2x4xrEl4bDwbC/MtipIfMFsnVrKRscF1L7BtelfyX
         qUo7/eFjLtZ+q9Vceh6arEyZwq4Vnk2R+7enGF/vdRzXZSsldqW3Pi/66JWOeQjz7+Tp
         23J5cqNcLFqxJbqJzA7ZcPpXk4jbuxjiirh6Z3hahnE1xBdcAnzEbDet+lnwojcs7OmB
         v7nw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+InhNn8XnOEX9n2PJiXsEkf0mFUyeZieQtXhXZF+E5Sa+3qOb62N3TWi3qMVEOQaQku2gAlGCsr48x5pzQch7cg0yPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxlLHJUraSg6jqNHPhw8R7x5JLb1sBl32oqnlimz0MvSMAwXrK
	EUMKET3F1s9Rlr6xt6c1hX98RM5Z4pR4pTeVIWRV/Mc3l0olknCDDHcM4ip1G/EuW8UYyYwq6Ck
	5rQH2VHQHUa2GQKX+vLJL8TvxOIcexkyrSsqXZwIv58RWZ8Z7/x8eLDsQyT4SUz5f5EgjZkHBJ2
	UbbA==
X-Gm-Gg: ASbGnctka825qlLRW3bPBZrgr+hbCy457AYsmA8AN1TZec+ZFAlyvyrdl5WC014c3Mf
	j1rG3IaPsV7DxDb7/+DgLlRFNGqq1FvI8Bm9xAJ/Rd4aWpJGxn9RcYHVNA3Nn5XjdPZ1aRhw0UL
	R8oeeJiAYZIGioTVwxX0xMs4yj0jTcKoKx6V7gikZcPN9sFbY9cNE3wPqqGZ+9uso7g4Jn3vgzW
	ZJAY8hYT//HPDBgmGA+RVn1s84ZgfifosOmEFvr8UoBQDpaCF5qCuJTbuDd/L6YvY7POW+/a6f7
	FStp6K+tS9XaztsQbRd/2+jhA0CAgmI=
X-Received: by 2002:a05:6a20:548d:b0:248:7e43:b6b8 with SMTP id adf61e73a8af0-26027c23f44mr12880575637.3.1757915732981;
        Sun, 14 Sep 2025 22:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmcsBuNESqmUSaUAZsD1y3Jo2f26HFzeSrkABroCjauRovq1uR/BneKn5f+6zwo9yQ8EBy3Q==
X-Received: by 2002:a05:6a20:548d:b0:248:7e43:b6b8 with SMTP id adf61e73a8af0-26027c23f44mr12880551637.3.1757915732593;
        Sun, 14 Sep 2025 22:55:32 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77618a7feefsm8575003b3a.58.2025.09.14.22.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 22:55:32 -0700 (PDT)
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
Subject: [PATCH v3] ima: don't clear IMA_DIGSIG flag when setting or removing non-IMA xattr
Date: Mon, 15 Sep 2025 13:55:23 +0800
Message-ID: <20250915055524.2187783-1-coxu@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Di8ctdLvQObUcovVBpovoElQMWh10va7Ifj7FWDYqYA_1757915733
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently when both IMA and EVM are in fix mode, the IMA signature will
be reset to IMA hash if a program first stores IMA signature in
security.ima and then writes/removes some other security xattr for the
file.

For example, on Fedora, after booting the kernel with "ima_appraise=fix
evm=fix ima_policy=appraise_tcb" and installing rpm-plugin-ima,
installing/reinstalling a package will not make good reference IMA
signature generated. Instead IMA hash is generated,

    # getfattr -m - -d -e hex /usr/bin/bash
    # file: usr/bin/bash
    security.ima=0x0404...

This happens because when setting security.selinux, the IMA_DIGSIG flag
that had been set early was cleared. As a result, IMA hash is generated
when the file is closed.

Similarly, IMA signature can be cleared on file close after removing
security xattr like security.evm or setting/removing ACL.

Prevent replacing the IMA file signature with a file hash, by preventing
the IMA_DIGSIG flag from being reset.

Here's a minimal C reproducer which sets security.selinux as the last
step which can also replaced by removing security.evm or setting ACL,

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
 security/integrity/ima/ima_appraise.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..5149ff4fd50d 100644
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
@@ -807,7 +818,7 @@ static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			     const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(d_backing_inode(dentry), -1);
 
 	return 0;
 }
@@ -815,11 +826,13 @@ static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				 const char *xattr_name)
 {
-	int result;
+	int result, digsig = -1;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		if (!strcmp(xattr_name, XATTR_NAME_IMA))
+			digsig = 0;
+		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 		if (result == 1)
 			result = 0;
 	}

base-commit: 7aac71907bdea16e2754a782b9d9155449a9d49d
-- 
2.51.0

