Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA23D76
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017551; cv=none; b=MgOfjcEbO9/3zi2t1zo0MzlUbM/f2hLq9+6PLMSeqi/RswxpOP5BcqXxIQgc/vDYZPTUoPCstuKS5bg+tVKFLzgR1JCxGg9SSh3O5h/VdKMus3cKu1YA9Xh7Yd3ku/wS+aFrc9eg+UrOiEqqynm3sJmgbaok8TrLM/Xfw56RPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017551; c=relaxed/simple;
	bh=Fw6HmamUNQVj03SSnFZ0JjwwpW2Unuuyy0L9OvC5+Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=H81cHiPE/yV6RUeVmz0SdOy99qKqeAVrATMxOR51wsUMvyPfkJmJ+ILpwGvNiySBLcrRACLhe4izCgxZT5u3COggrigopWXA/zaP5vgriAxqlCWuHsKyWDA+GmQNGYtYdzk1BVB5+jV16bjb+6WIcmfsoIUintjHIp0M0VXJs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGZ5/vTO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGZ5/vTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760017546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LuKvTV/ZvxsZcI+HNaWfxeETY2vb8WWG5aZ1soizNHk=;
	b=NGZ5/vTOT2bisFORCx/ICq/AQ273YBog3oCeowNuQ3RHIxsBCmHVUdAp8/Uju48Iks6mv5
	tfjLLJCwspM2o+ovagpgmEKTQc/BBPFvAn84Ac8+iOYIu1d9t96wWPXc8cKkKSj3eF3UpY
	hmpjZNH4NeDZQSX4tJtPg3Z0prsk6Go=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-W4qAdbiRPuqEwtDbGqBfKw-1; Thu, 09 Oct 2025 09:45:45 -0400
X-MC-Unique: W4qAdbiRPuqEwtDbGqBfKw-1
X-Mimecast-MFC-AGG-ID: W4qAdbiRPuqEwtDbGqBfKw_1760017545
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso5360205e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 Oct 2025 06:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017544; x=1760622344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuKvTV/ZvxsZcI+HNaWfxeETY2vb8WWG5aZ1soizNHk=;
        b=I8gPUwQGDC8+JGvQ4Lq0RwqRStN4yooLGnHy5Vylmo2tC3u/gk89NS1qAxa87TIRwH
         Lwtluex9dVmNex2ADTYoM+BpEtU35zpIeb1L/MDgEUBGBFRCLN6v2DGgFkQG0RDM89GP
         MTPsF0/wc9Ehat66ZLbvWGD3DHT9KgGSG1Jd+kaUoXa8AozykTZz3qrfnQ4uGLoXdNbk
         UKSqsM8d5r8SnXMX+cEW2QRSb5Pr9zmhoe0HCOK8v1y60+u2EJX9jEKSG0ftmWSiXfdA
         Ybs3wxc8bXemqikvcQaOILshrsPLBGxtL6oTK7GR/sv3dE+SRQgPiYkY1tJ4wb3ODu72
         pKBw==
X-Forwarded-Encrypted: i=1; AJvYcCVe9FjoH2y458XRquJd2h5O+PAwjek/us+Ziyd52v2r5JK0VR9fjMVys+C3r/8TWGTUCn5cQoHCA7Q5rurog/ZQC/X1z2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgLzY0dbcJTAeaVh+kvk09owuxCGMuk2/VGlgiRsHIFJOm1KS
	fXflSINLzESZaGe4NTCTLFylq1LJFaEvKZSEjcQ4FJhQWY4cpQndcGAuiZss56uVqLAifPbgp6n
	GBcT09wt+d51Y2nPsej+EYo/5/Sw2YTa7xuz/ImBNHjGPJs2N0MAvtFko8P54BCjkZDW4HFEhSl
	hSXQ==
X-Gm-Gg: ASbGncsx3e1NTIeoONPEgH3GiCQtXp9e2THbBi6tDZbcbAz1oRsw5M6IOCnH3Opk+TW
	+cTILu5GMPXpTlWJgAzoAyf4fdNGgYIH2EVB1lO3a5Q2rzd4s8zz1i75FSatVdbQyHZx/xO2GQf
	9YRR1icVsAMfFUkc+yePwDJzlef+Wd1wqZVXOl7CgAptkv8zCR2VDBRS1wYcTMoi4OPkT9ypmZq
	pWgGwnKnKOiI909veu6pczoF9qUXmtPzyM4l83bS9Pq6IbudGrKnacxXADhc4pE6kJp4K+SVvRc
	yNghMkGvw2af+U+vcX4ot0pFY8e30duA5mtT
X-Received: by 2002:a05:600c:8288:b0:46e:448a:1235 with SMTP id 5b1f17b1804b1-46fa9aadeedmr76517335e9.16.1760017544447;
        Thu, 09 Oct 2025 06:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfgpeOYz8rB6dmj0SJ47sQixPMa8U/4+cKkDJEI0Y54hBFNm63lOaoILSZN0gkfmu+whVYIg==
X-Received: by 2002:a05:600c:8288:b0:46e:448a:1235 with SMTP id 5b1f17b1804b1-46fa9aadeedmr76517105e9.16.1760017544025;
        Thu, 09 Oct 2025 06:45:44 -0700 (PDT)
Received: from fedora ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf16ac01sm50840625e9.11.2025.10.09.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:45:43 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] nbd: override creds to kernel when calling sock_{send,recv}msg()
Date: Thu,  9 Oct 2025 15:45:42 +0200
Message-ID: <20251009134542.1529148-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8-qUon9X9w1QHp5TZ4cXLdkZ5PRkzkpOR2gQy_T8V3s_1760017545
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

sock_{send,recv}msg() internally calls security_socket_{send,recv}msg(),
which does security checks (e.g. SELinux) for socket access against the
current task. However, _sock_xmit() in drivers/block/nbd.c may be called
indirectly from a userspace syscall, where the NBD socket access would
be incorrectly checked against the calling userspace task (which simply
tries to read/write a file that happens to reside on an NBD device).

To fix this, temporarily override creds to kernel ones before calling
the sock_*() functions. This allows the security modules to recognize
this as internal access by the kernel, which will normally be allowed.

A way to trigger the issue is to do the following (on a system with
SELinux set to enforcing):

    ### Create nbd device:
    truncate -s 256M /tmp/testfile
    nbd-server localhost:10809 /tmp/testfile

    ### Connect to the nbd server:
    nbd-client localhost

    ### Create mdraid array
    mdadm --create -l 1 -n 2 /dev/md/testarray /dev/nbd0 missing

    ### Stop the array
    mdadm --stop /dev/md/testarray

    ### Disconnect the nbd device
    nbd-client -d /dev/nbd0

    ### Reconnect to nbd devices:
    nbd-client localhost

After these steps, assuming the SELinux policy doesn't allow the
unexpected access pattern, errors will be visible on the kernel console:

[   93.997980] nbd2: detected capacity change from 0 to 524288
[  100.314271] md/raid1:md126: active with 1 out of 2 mirrors
[  100.314301] md126: detected capacity change from 0 to 522240
[  100.317288] block nbd2: Send control failed (result -13)           <-----
[  100.317306] block nbd2: Request send failed, requeueing            <-----
[  100.318765] block nbd2: Receive control failed (result -32)        <-----
[  100.318783] block nbd2: Dead connection, failed to find a fallback
[  100.318794] block nbd2: shutting down sockets
[  100.318802] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.318817] Buffer I/O error on dev md126, logical block 0, async page read
[  100.322000] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.322016] Buffer I/O error on dev md126, logical block 0, async page read
[  100.323244] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.323253] Buffer I/O error on dev md126, logical block 0, async page read
[  100.324436] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.324444] Buffer I/O error on dev md126, logical block 0, async page read
[  100.325621] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.325630] Buffer I/O error on dev md126, logical block 0, async page read
[  100.326813] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.326822] Buffer I/O error on dev md126, logical block 0, async page read
[  100.326834]  md126: unable to read partition table
[  100.329872] I/O error, dev nbd2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.329889] Buffer I/O error on dev nbd2, logical block 0, async page read
[  100.331186] I/O error, dev nbd2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.331195] Buffer I/O error on dev nbd2, logical block 0, async page read
[  100.332371] I/O error, dev nbd2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.332379] Buffer I/O error on dev nbd2, logical block 0, async page read
[  100.333550] I/O error, dev nbd2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.333559] Buffer I/O error on dev nbd2, logical block 0, async page read
[  100.334721]  nbd2: unable to read partition table
[  100.350993]  nbd2: unable to read partition table

The corresponding SELinux denial on Fedora/RHEL will look like this
(assuming it's not silenced):
type=AVC msg=audit(1758104872.510:116): avc:  denied  { write } for  pid=1908 comm="mdadm" laddr=::1 lport=32772 faddr=::1 fport=10809 scontext=system_u:system_r:mdadm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=tcp_socket permissive=0

Cc: Ming Lei <ming.lei@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2348878
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 drivers/block/nbd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6463d0e8d0cef..d50055c974a6b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -52,6 +52,7 @@
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
+static struct cred *nbd_cred;
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -554,6 +555,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	int result;
 	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
+	const struct cred *old_cred;
 
 	if (unlikely(!sock)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -562,6 +564,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		return -EINVAL;
 	}
 
+	old_cred = override_creds(nbd_cred);
+
 	msg.msg_iter = *iter;
 
 	noreclaim_flag = memalloc_noreclaim_save();
@@ -586,6 +590,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
+	revert_creds(old_cred);
+
 	return result;
 }
 
@@ -2669,7 +2675,15 @@ static int __init nbd_init(void)
 		return -ENOMEM;
 	}
 
+	nbd_cred = prepare_kernel_cred(&init_task);
+	if (!nbd_cred) {
+		destroy_workqueue(nbd_del_wq);
+		unregister_blkdev(NBD_MAJOR, "nbd");
+		return -ENOMEM;
+	}
+
 	if (genl_register_family(&nbd_genl_family)) {
+		put_cred(nbd_cred);
 		destroy_workqueue(nbd_del_wq);
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
@@ -2706,6 +2720,8 @@ static void __exit nbd_cleanup(void)
 
 	nbd_dbg_close();
 
+	put_cred(nbd_cred);
+
 	mutex_lock(&nbd_index_mutex);
 	idr_for_each(&nbd_index_idr, &nbd_exit_cb, &del_list);
 	mutex_unlock(&nbd_index_mutex);
-- 
2.51.0

