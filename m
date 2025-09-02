Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBC2D5932
	for <linux-security-module@vger.kernel.org>; Tue,  2 Sep 2025 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787125; cv=none; b=UdHWEi0wvTKYktIJOdfm8aF7VWk66cw/jzLNpeIY9j0Aq47nNnPI6TGni4xlW5l7sxiZJ0ZDrkTxVN7BolKIA+vXOVhaHBA66WEiDp5DENhTKDwRDmf9dWAbh2pS8v7qlhZKibceZ+GpVKzZ7VPcvnjobHCZ4Em0zl5iALk/f4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787125; c=relaxed/simple;
	bh=KGVqkd0oWHkbJ+ZQ3pjCuoMltYbH2zy2sVQQCrEM91U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Qaslq0b2H7Bh+DH7q1/go5VX7NOKOO/4m55F+9FdR/pNMmql/M19eLkcWi+iHbUeQPY5753xWKe2OiF1iJ55IfQpWKmmY78xaRVOOSB7YGwNF3uw0UkvqlNeGUBv6O0F134cTtyGhzBUgo5tywFJ6bF2XPYcgZPRKqa6q4RUdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbc9rWWa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbc9rWWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756787122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yceXk2CDlZjXkspmIbhQrCudqcmdaHsA3xCQZcIxoPY=;
	b=bbc9rWWa848iv/2gqB3sgMQnrN/w//TPsjBBVV17v3rY49AY9wqj1rtKLA68sgtUldD2BV
	9e0kgUuYN9vH0pj5cOxonhF74waabGGjFGuoizlOs/eMoWY5ZrVGXvsuLrowyjcZJ/+UuD
	niWmcTQM9FSKNRZy5IpHBA4VVBJAVQ0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-1wK7b2cbOUaSoHr22NPSIA-1; Tue, 02 Sep 2025 00:25:20 -0400
X-MC-Unique: 1wK7b2cbOUaSoHr22NPSIA-1
X-Mimecast-MFC-AGG-ID: 1wK7b2cbOUaSoHr22NPSIA_1756787119
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244582bc5e4so60122285ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 01 Sep 2025 21:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787119; x=1757391919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yceXk2CDlZjXkspmIbhQrCudqcmdaHsA3xCQZcIxoPY=;
        b=cSe1dFWyCg8FajidgdOzxee43us3XGAlhc7Q0SENgpudESnETpyMBKq2P9qhmSgTdO
         h+wbq+dRyyd1UIkIz7jUDgbvxjVcXCNk6tOdarYoH62Zbo5Llx7DRtyOGEPj1+0EnvDn
         5exm2a+TU4nXt4Psoj6cX734QarBoh/QgjOeWvqILLXpB1bYQ82LRBc5jwU8v5toIOVW
         C6zr5eSlfYN2M18nBfi/DucbjoMD3ueH2psGEMPvnDbFAaq5t8olH9iz1e92IV752zWb
         nOrelmvdbxjN/4mccoFrZP6nxYmJR+UKNt3Er/efDzr0r46W/s2YGhHb+qjeK/84EazF
         ITZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEyBKgDOHe5uuL3rvy1IZXGVk0P9Ss2uE4+CX1FqGYNVZdVix81LJtXxUfagKMWguP3JWvbn4Hjw87Q+A++0EVG3J/zYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxov8iWtrzUOLwvhJbfSQo+fT1VF30L2K7ia/uy9hj44Ud9N7r
	nmHM1TcJaPNNOKQJqv9ggibWhFSoKyoPUJ7U5cy1tmBAlBpf9NeHImLtLAvts7/98xsosU1Xv5C
	iH6/9gISWzSb2zpD4883yrUoE3JllOkqJoRog1eGRKmeVr3Q8zYDOiPG+T49lOjtCLaaT+7VUHU
	A1CA==
X-Gm-Gg: ASbGncutlPFKf15GuwUXdmRCcUQhZ07psJNzQL/Op6YF1xzzCJqURbfuuygWPNkmRlT
	+7ImNYN2rrgPf9Gz2wMS3Ws1NJtP+LCDEGpncwCzOmYawjrGqiWHaNM+kMeEzvRZ17E2QLErAHj
	reG3XxRhfdBruy6+3OPTSu58ooOnUbMdg3aTNBadayZm3CY6Zowd0BLBSk6FeTwjCVjLvgv6+Gd
	9M++gf1HsmgWShHuudmrt4K61k6aRVL1Rbz/d/dW+0U238SHLUo8eAD62reILAGcRkWaBfzcOe3
	JI6pU+eAHf74IqaCd4u6hEFT7hj31Cs=
X-Received: by 2002:a17:903:ac8:b0:248:9b68:f522 with SMTP id d9443c01a7336-24944ac8802mr119741125ad.43.1756787119152;
        Mon, 01 Sep 2025 21:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6qHS5CaJlgiiZHBDHXTwlaeAvO21OpILjrDjJxhf0jrDdLhZ4exXvJAzU8wyGG8a51R9XhA==
X-Received: by 2002:a17:903:ac8:b0:248:9b68:f522 with SMTP id d9443c01a7336-24944ac8802mr119740845ad.43.1756787118749;
        Mon, 01 Sep 2025 21:25:18 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037285b9sm120009035ad.44.2025.09.01.21.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:25:18 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA xattr
Date: Tue,  2 Sep 2025 12:25:14 +0800
Message-ID: <20250902042515.759750-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hC02jyyk_NdzCO4Um-ZeANf2TNOt5dQOUABUUMB8A3Y_1756787119
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
 security/integrity/ima/ima_appraise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..fc82161f8b30 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -708,7 +708,7 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
 	if (digsig)
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-	else
+	else if (digsig != -1)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
 
@@ -794,6 +794,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
 	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
+	} else if (result != 1) {
+		digsig = -1;
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
-- 
2.51.0

