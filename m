Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B0DDAB
	for <linux-security-module@vger.kernel.org>; Tue, 20 Jan 2026 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867411; cv=none; b=jaAM7ZC0yhjDOqB4pts4ZVxWN99I9utTs5I9hm+mYmWxhWqEhBonPcCwRcldmj0d2+8FJU8C+2bJttZEw7oCeVxrGGYQakzlsvkwfsns2tpnldYSjXLOJoLCGCKOfYPjwS2s3X+HuVO6gR+LzrmnuFbA5lI8REgJ2Sj9OI8nUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867411; c=relaxed/simple;
	bh=EGch+6xPIDWgRSoLQfr5SD+C9COPAXoivhtOGAGAYXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCU1DnxiqTdgqjNE10HPRRhT0KKN2OqGvANvzXke2OxZmu7UdiS9I0FBobA4+2GPcqwUSVbX4fXK5Imi4EkvRy1m5Ew5HNK6JPgXjAV18oCCfARHWkwRgr4CktTE4wvovz2xS0Yzjrb2Pk8K8EAKYsaC6Hd3UGJ2JK2VM32MKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeGcN4Nd; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeGcN4Nd"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79407df9391so2098537b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 16:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768867409; x=1769472209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfhKJnzVxCnG5LtWVAC7A0MBFk4q7eM2qauK6G+whnw=;
        b=UeGcN4NdLaRUNfUwUBvWnSYUscmnbOFsFGVbPF4yDptxNeNlq4yuMeJmcTFHrjdBkO
         ewf75Vge/TRsXDcKxBk2I9pwLCZPTm89QhbuUP7OmreFgG4EJxnqeZJV3bBDDZ1VxWhI
         HxDeKKe0g7MiZXBifTkx9x3VKOUwTKmw59ArgeT6MHEe/ux94sdH1NI9pR4AHM1IRU6N
         85SyKrz9Nw7zZ11xYbFVxhKFmmO39TupEPWRuk5HelIA5oPteX0uyZIyUb6ZP6Dal5lF
         lNVlK4zXQierVcYZECeEfRjq4+KFy2KZTRt6ffscC5sV187ibuhQjGlkmO68c58t5ZNr
         176Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768867409; x=1769472209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfhKJnzVxCnG5LtWVAC7A0MBFk4q7eM2qauK6G+whnw=;
        b=b2JD3zLuUV68VGcWQ6DmgsXt9kN4ftJukt5piWG03uslmYoULLS5X6BYqFj9r6tsI/
         HUngrOMQrwjzq3ixdBYZznKHDfLXehq+nmnkqoFKVJ7qZ5YWE/KLPchEEzqz/dIXSU82
         yrs+fE/2JNvtORZXxw++V2EC1iInI4TTKU4I6EPE8EIO3Q46sqb3/At77ZPoMzbBHMJ5
         TDhBbqitk4E1Rc1sdI/Wm9e6NCjMONA5MOSEbi/iOq2KInzBV3/5DGuMjVWJ3iK9Mfzj
         TUp4XTEACGB+kAjyRYkwHmvbsy8Ne8KBnJlZ1VF/9Rk6uefi10LeNtso+4Xl2UigsOrM
         smfA==
X-Gm-Message-State: AOJu0YxZwPcKoPpkGoQ4IQIouizvtIXX9UQHWXk/VcSlJiW6oaYJWhC0
	dwxIDcCqtd5Dx7h0KadkhMrACIJZadd3R8cPhzYuaukZLfFyop24MoAm
X-Gm-Gg: AZuq6aJzIolG+DhjhWUxM0KiPchroszdZyKmZSq43K2QNgpjzhro5LvNNNlHZdOAc/I
	P2RC5dpGIBqJRSqlbt8upo7uU0yPYftTlGtn879Y3wI+VCuN808ZxGrcLtbkBGTULygzy8X6LzW
	+A84MPkxEKJAGNorPg9y+i2IwJ+2mJoIMMK//PDFEWcWi9q+EsDxn568ttXwbm5pClT+Nt8MX5P
	xeckBmHM4B96JWrmrL9mbfttMboYeuboMPGnoFToQiy0pdjY45mT9KZAe4YlUIsIlk2vs15i8Rf
	5/+hynz32oei01GN20FOxXL/IaPIWYPbWrH9NHQMi9NzdJYUOUtYFaCZZcTow+AtiCSe38VZrhf
	Pk47QEbzVef8/3aPBwbvxxMAwoLGlVMPiWAJYXZEb8u/l4SW1F+TtgW6x7YI/yhZ7CeSaKcSlhf
	02+bRlBBCz3Mih8F1tDRf9OB/k7cY=
X-Received: by 2002:a05:690c:1b:b0:790:4bcd:dec6 with SMTP id 00721157ae682-793c670b447mr100664737b3.26.1768867408677;
        Mon, 19 Jan 2026 16:03:28 -0800 (PST)
Received: from msi2.sky.cl ([2600:1700:65a1:210::47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm45933607b3.12.2026.01.19.16.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:03:28 -0800 (PST)
From: Zhengmian Hu <huzhengmian@gmail.com>
To: john.johansen@canonical.com,
	john@apparmor.net,
	apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengmian Hu <huzhengmian@gmail.com>
Subject: [PATCH v2 0/1] apparmor: avoid per-cpu hold underflow in aa_get_buffer
Date: Mon, 19 Jan 2026 19:03:06 -0500
Message-ID: <20260120000307.369587-1-huzhengmian@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series fixes a per-cpu hold counter underflow in the AppArmor buffer
cache. Under high-frequency execve workloads with AppArmor enabled, cache->hold
can wrap to UINT_MAX, preventing buffers from returning to the global list and
forcing repeated kmalloc(aa_g_path_max) allocations.

Summary:
On high-frequency execve workloads with AppArmor enabled, the per-CPU buffer
cache can enter a pathological state: aa_get_buffer() decrements hold even
when it is already zero, causing an unsigned underflow. The resulting huge
hold value prevents aa_put_buffer() from refilling the global list, which
starves other CPUs and forces repeated kmalloc(aa_g_path_max) allocations.
Because the AppArmor pool does not shrink, this accumulates into large
kmalloc-8k slab growth over time.

Repro (QEMU TCG, 4 vCPU, 1 GiB RAM, v6.16):
- Unpatched: kmalloc-8k objects grow 12->16 in 120s (run1), 16->20 in 120s (run2)
- Patched: kmalloc-8k stays at 12 for 120s

Notes:
This fix targets the observed underflow mechanism without changing the overall
AppArmor buffer pool design. Happy to provide the reproduction script and logs
on request.

Changes in v2:
- Add patch description to the commit message.

Thanks,
Zhengmian Hu

Zhengmian Hu (1):
  apparmor: avoid per-cpu hold underflow in aa_get_buffer

 security/apparmor/lsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.52.0
