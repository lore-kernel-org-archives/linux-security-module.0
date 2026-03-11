Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152F31E827
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235395; cv=none; b=feJjGiPuUc6s2rx5h43Kv+8YsTrIgg2vmrQf5SQHzMmIHgyuEsh5cMhC0nbC2Oi2eOdv6uKC6D/iVpaYw8l8SkHONhBXhniXXYMx8mBm7xYrGm8nahx/WSG9K2QDjsuN/zu7gmfd0Oat9ZqkYMrlEhOuL3olI/cRhF19bKddpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235395; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PB+WDzMZV5gv4xp6tT7Ljn1cyF3ftNSy62CTzxmNd+lrVsaw4wWgapheXZ2ohN/oEqg57TV9qALX7F9OiMIe8jueFrNeCHQEdpvEpz/3RjCM6oaOLs9TYa4Pe8hiJxkKDyZm/w2FEgKFyNfTLbNjZh0BGgcpKsEERPLIlRV487E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2423871e0c.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 06:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235393; x=1773840193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=LE8W0JJOKGbZIeecNLGV8pHgnIuJjhtSpbmxLijMcqpmAdCC4jiPAQJbvU+AsMx3ax
         RdgRd5N3oibeIm3RLFIdEq4r7d+hpprWVCFU9D/OCtPXxcnFR4W/eRheddIUXR+QwDpb
         Yv3Y9jO17UybKp74NF/t7phwwxFanHBVltzKOwj5ozmiTlq7CCEJErM1SI++1q99UaWb
         IFZCEwNWumcNIVsIgnsoheqVh3W04rxOXDYEBMtGzJ4L1WxjByzZTGT5ADS9hLqslZlb
         iRDIMEJhlp5GGYym4nQSybKfVuDzCYW4BX1YsRoa83s3DNI2NPL54LB8G8jrmh3ClyJJ
         +oXA==
X-Forwarded-Encrypted: i=1; AJvYcCWTFzL47Y0Bca5VYueCAJrZVDW8x1fZNZ4ADEh4JLeSmskuZzm0r8SExFMMa14zECC12uyO+EJwpFTlg/0Y5w4adoDOujo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjtr7kPRSgTyorpUjgWfps1OFacE+2vPxvML59BdPU8vGLoOG0
	6Y9up3jYb1/gy5HBph47P/epx+nTTQNIH0MZyGJSLMuHW19HkiUjLuuaiJ/7t8bQ/38=
X-Gm-Gg: ATEYQzx5DkQVY8N5gMJDERJ/xAKIYI5489wSMah/vRwVuBpZE0G6hLAr8MTE/LbQCzU
	eum/Ekz4rChkgMH9CxvsxqzNfJ0IcbW6eBtGx+xifzwh0Q1S/xZnURprkeUKfKODpsmcO0oRzHE
	PwP2O+S+XXtFkkucmyCamtLU4wo4RiGvoUM8KGoUauiKKbTPguyqgLaldSYJULzX6A/ORkSlaL0
	OP5KMAE3gi6DHftdDvINcRuHOx/GOYCwDPjzG+jiaCVgfpM7btbE/wdpzdO6DQz1mXxbqpcdX2v
	46fubbMM/+N+3u6z2/R8+pXbKHrPhwxU0kmgPHkRFWFiquEwnKnRPw/mvCWXsit5duMSYeuMB17
	zBFHAvhtMPns3Kqeo2cXm2FMaSlcOqRihNupmCtB8ILXGZCdM6mEOfFnoWL9F24PFjxl554+lBh
	7jmdKkbQiyRfbh0BmOtQrKbSruoUrtjZanTaIZQC/ANpSpiX6kUJvioYeduyyH
X-Received: by 2002:a05:6122:6090:b0:566:354d:9f4a with SMTP id 71dfb90a1353d-56b47448dfdmr922156e0c.1.1773235393656;
        Wed, 11 Mar 2026 06:23:13 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b46336442sm972083e0c.5.2026.03.11.06.23.13
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:23:13 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fff774800cso3500736137.0
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 06:23:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUby+IyAP03fsUWbOV6iOk3X5h64kl+SK4DjuCNoyxI4FNRkQ2EjVXMu9+6xvQEIvrQHGnJBrM6FbHpTSinae/z+NLZx2I=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
