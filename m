Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4783B0AD1
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148931; cv=none; b=aTNKHblbDI5y3WTrna2UQddniksxdR/pnUXDN/679HdXMPBqQvVXG49OygLpNeDQwwQVlvVOQrZKN3Czf/uIfM+gmmHs5Ty4qLxoMWkw+VWwCvKNKeSJZ7BpXjsCJ5VjucD7+xF44ttUpGFj7ANATL8Zqr2ST5eGNwgoDUGLLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148931; c=relaxed/simple;
	bh=7C48eJwQxF2SZSyojjO4eehKdtPdDBqSboD/LkVXOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JH5D31Wd6rCIo7w5YuRVdwJVDXB4W+EGqHFvW0nLiVXGqqUCqDCE8RXkY7lB9TJVTuXX0uT4SnNf5MaN4zwvlhq8NXKygwRUW5ZRytS8c6i96vcyCxVrRIDBIU4UtVxDOSmUN839/jCnxb/6UbB8xMiGCBuE9mu/1wiyBumWo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADQQpd+b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADQQpd+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	b=ADQQpd+bpcMvyiI6BuK6I/AtlFPVjRaT1jbvm8x0bcg2sn4Mv+l/q+wGsOaa7zGZavpvJL
	HOw6n0NTrJxN8BVrJlzy+3Oyq/AicE10gafpjzfnHFVMImjvlOy3qRSEO7jpexZVWETsUQ
	RoRPrXnJkd5ZbUZ0X+x9wM3CIJYSD9c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-Pc_OinEbMMasEU2J4BILOg-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: Pc_OinEbMMasEU2J4BILOg-1
X-Mimecast-MFC-AGG-ID: Pc_OinEbMMasEU2J4BILOg_1773148925
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd849cd562so1322191585a.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=SzNfbjaFm6MP1yHGRTgdyfnicT1TmjM3buzsC0R0XDEmNiSzNODX2gM0b9Nh+JfXAk
         n4NBarYGwjitvvMmcdy9mOy0cIHy736zUyW4W/y/KFvswxXuKAEDFuMMN4OCKZqSZbcz
         6hRt1Q/Vbt/CGieFvXg/ThzU3PP59DlOSAmA0uR6b/KHvVxI0S8taaYZmcyUkevNyv7n
         ThWZ/IXWi52koFBZqXq/i+8Vir93PiN7FjAomrrpqyyZeytUAaPVGhi6Ib9GMeb1UzcR
         1QoNRrOV59HLsudbMrNOxYTzsnhZnjDYNhVH5T9oR22IaadRkJAbHQo/oOQN+8N4zPZf
         tslw==
X-Forwarded-Encrypted: i=1; AJvYcCXEeiVZjIWPcZLURpPlRhpjFtcCEf86OLCTKvCUVh8+JEMFU+/EAeveDNsCnKMACfzex+qvAiPJSeOH+m2EmHydGb4OFX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxli5mE90Yiq1IMDtFYFchi6lHQ3bB9JikB7se67DZL7B0F2z1/
	dlXWuundSI8F2UbiSzDttPmMfuC9PoBRW9X49LI3K0/4jgztLwfCKAiLV+oMaZdlLZStaPrMsM0
	P3eEZbcPva4oMoQXXoePBsNkW6Dwpsp6lXOf+VAOoOFouDaQ+jI+ZZjS0amifDvfeqZvr+ob4ZB
	6Isw==
X-Gm-Gg: ATEYQzzHhbKmklHqlyAG82tqkLUp0V9C3/jeC62zJrjJQPfW1bQCzZWRFAKXr5/D1Bp
	Z8wUQURR9uCUrX+pK5yrOsE65GKlRu8eNeWVdL6OW6tS7n8W9WsrML6Xt8ItOarQ+Q5TKul67gr
	Zyc+8gasYzt/DM6rY0TYyGNdiJZq9MvA3n1HGBH65NzAUmXtBcYkFZ5dSWKTZHknIJIuDbNuux4
	VKPwRfIJ7U2qlnhROIbVdY+9qOwdTSnIhfkGuN0pTBHztp51bebmdtU9XLt5P7qcauYPfJKk+KZ
	PdoPaL3cDElcqqqW0YV/DslaZCVzYCL2W9DPvHV3ya8mudEXv9YfltaK+iwlgO/YECKrb1aELfv
	TGodmUJzuZGtbmWJzRvQfsO6u7dk51C8XxQm59nSe9nTnwHlMUvOzOnbV
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830784885a.45.1773148924683;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MoAcpGOpKTqHoNvwmTAQuYSsAR8tknaqaEod1Qk0YHo_1773148925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

