Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455211;
	b=aKtRKpxJuckFzOUHBZG7p5qSrruUajGGw5noA/4jO7Y56r8vPp0zMAdbpkRN2d8z7Omu
	 8O63mHmHnh5NCFRzoJk/WSILiSNK2Hr/q6KO0MnFvlnq1wImcwEQOuBFaCp39fmFtKlUS
	 K0NalnZsbFiy4dEi3SPir22jNcnj5tg0QLRtG+nhLb/a0qNC5gBr+RuXWLjmE7/son7PF
	 Es0frIQ4Io9pB88vtiDPuu6YJoSoJFTdRbQZqQlSoqmgObhjySHYzaqIvkHc96eVvlGaT
	 /v0X11BxQ0zu8za+4PJh+S6jvqlyNgx4VtnLnLEv5/pYOUgNiRTTHnyBOBOxgobGHbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455211;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=mulxaJdMD/Jl8fsXEmtmJSnhKCmKvuqsIC3aD5htCXA=;
	b=ZWk18qmgTSMFwG1QlKjb5UzWtTC6gXwGd+OPX/Vm2iGSrSXjTQMrb/pd5fjlOSAc1CLn
	 GbGt6S1XgIWJlCryTWm4O2USOqb4pxIZ3YhrVA/Po6xdnSiUc2UfnawzPDOUwioQQ+7CZ
	 F9uk9IaQFgaa3K4aVLi2oI1hRy64H6snoaGVE+b/SB9l9eXQjt5pICMnuAasP8zaxamV2
	 YFtrpD3goDWpOs2Tlc67CXp+oSlcEnoSnA1wrt1keKAOgkq/cseTjF0SJGY2I5NbVw6I/
	 ugYa2tUxeWR0IJYPPuK+mv6ZUEmmd/KmRmjb9+4eQanawP6+COMgzsyO6QzSlRG6yjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pNhNDrna;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E3606A319;
	Tue, 20 Oct 2026 00:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355E3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pNhNDrna
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mu
	lxaJdMD/Jl8fsXEmtmJSnhKCmKvuqsIC3aD5htCXA=; b=pNhNDrnaaKMWzHvQJn
	IgrA7/Dk6dvb+Ixkdy+y1QEOK3dAUWE6BRWcUjLnEk8fJebBh8EoiBtkiZ2QKTgy
	Ran0fv7jz9i25pEAlKaQh1SI5aTlXBTr/QUd6ubcVJFV84FaXz7hcMng7EXIpa5W
	Ha96JNuhiicZvMYsUsBdy5w24=
Received: from shaos.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDX8xoIstZqXXVTAw--.37817S2;
	Tue, 20 Oct 2026 08:13:07 +0800 (CST)
From: shaos <shawnq1@163.com>
To: john.johansen@canonical.com
Cc: Georgia Garcia <georgia.garcia@canonical.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: mediate AF_UNSPEC socket disconnects
Date: Tue, 20 Oct 2026 00:12:56 +0000
Message-Id: <20261020001256.888314-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDX8xoIstZqXXVTAw--.37817S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1fXFWkZF4fCw1rZrW3Awb_yoW5uw4rpa
	yYya1kKrn5GF1fJw4kt3WUWF4Fywn7Cw17Was8WFyDAa98Gr48A3yIy3y5u3W7Wws8C3y5
	ZayUWaySkF4DCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut8nrUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8hMBD2rWshPmMAAA3k

Hello,

aa_inet_connect_perm() returns success immediately for AF_UNSPEC before checking the active AppArmor profile.  AF_UNSPEC is the socket disconnect operation for TCP and UDP.  A process confined by a profile containing deny network can therefore disconnect inherited sockets even though ordinary socket creation and connect calls are denied.

HEAD commit:    fe2ec83746e501645709761605c2464a44fd2929
git tree:       upstream Linux checkout, local branch master
source version: Linux 7.3.0-rc4-70-gfe2ec83746e50
compiler:       gcc 11.4.0, GNU ld 2.38 (build details in reproduction notes)

console output:
https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf43c/raw/fab5c58d6f184f5fab88a3a31a80c2b919efecf0/console-output.txt
reproduction kernel config:
https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf43c/raw/b9192c97c92fdd3b59089704bad6fbd0a33ccf06/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf43c/raw/92c7dd098a227276fe3daeea45996e2848e66439/poc.c

Build the kernel from HEAD with the attached reproduction config, then make a one-file initramfs.  The PoC mounts sysfs and securityfs itself; DEVTMPFS_MOUNT supplies /dev/console.

    mkdir -p build rootfs
    cp kernel-config.txt build/.config
    make O=build olddefconfig
    make O=build -j"$(nproc)" bzImage
    cc -O2 -static -Wall -Wextra -o poc poc.c
    cp poc rootfs/poc
    (cd rootfs && find poc | cpio -o -H newc --owner=0:0) | gzip -9 > initramfs.cpio.gz
    timeout 900 qemu-system-x86_64 -kernel build/arch/x86/boot/bzImage \
        -initrd initramfs.cpio.gz -append "console=ttyS0 rdinit=/poc panic=-1 loglevel=7 lsm=apparmor security=apparmor apparmor=1" \
        -nographic -m 1024 -smp 1 -no-reboot 2>&1 | tee console.log

Under the deny-network profile, socket() and connect(AF_INET) returned EACCES, but connect(fd, AF_UNSPEC) returned success and tore down the inherited connection and listener.  Two fresh boots matched.  A one-line control that routed AF_UNSPEC through aa_sk_perm returned EACCES and kept both sockets alive.

Impact and prerequisites:
A confined process that inherits a TCP/UDP socket can bypass the profile's network mediation for disconnect and disrupt that socket.  The finding does not permit socket creation, bind, or arbitrary peer connections; no privilege escalation is demonstrated.

Run the normal connect permission check for the AF_UNSPEC disconnect case:

diff --git a/security/apparmor/af_inet.c b/security/apparmor/af_inet.c
--- a/security/apparmor/af_inet.c
+++ b/security/apparmor/af_inet.c
@@ -425,7 +425,7 @@
 	if (addrlen < offsetofend(struct sockaddr, sa_family))
 		return -EINVAL;
 	if (addr->sa_family == AF_UNSPEC)
-		return 0;
+		return aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
 
 	/* do we need early bailout for !family ... */
 	return sk_has_perm2(sock->sk, OP_CONNECT, AA_MAY_CONNECT, profile, ad,

Fixes: 89ac6aa752ec8 ("apparmor: push inet mediation into profile callbacks, and improve auditing")
Signed-off-by: shaos <shawnq1@163.com>

Validation: Two fresh vulnerable boots showed socket teardown.  The one-line fixed-kernel control denied the call and preserved both sockets.

Thanks,

shaos

