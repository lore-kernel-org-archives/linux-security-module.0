Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657338;
	b=t4zgdaUxr0U/hChlbt7VYvYLkw894SZej6AE7fS+I4bLVBxjrxNu0facSaUy/aA3TKPW
	 FSw5LbDoKPI6kkWyQV2DtMv+aZAWvY7x/mojUdvgMAsawUJZtUCzRS6aODMseTEUTMh6g
	 7z2fy3b/gPYFrqxc69B4kLKlpPkX+ojQ8TeUUKbK53JcHAccBi8+1Vk1Rzkw/gA25v0sx
	 PlQA5GTc4gx5Dd07NL3RgLpT/vmwZD4qnXYH5t9wEfmadbfLori+prKnxmIzO7/PfBQDd
	 k1zgjghyQ6MqQ2a+JGU46QlJMOec53no9NOPKVXg2odfWVYyLBf3GHO/I7p9jTd4+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
	b=CGcfGE3YW/TG37GO5pTfBGQmrwem9W9osXi2H0GtVqqKoB8MKkzQ0UnLTpbRRIpgUt0B
	 +hM115kQSLXIfxBFERj6D++FQn13qA++S+8/qwJRpVYG8R8HZ8psEJh5yqvN2E4xHlHDs
	 AHDpWeRq3TRh9Fus9l6OSAifs0a+FprLuK4HD36QEhz8Fa2oPASe8QGbz6jj346Bt26Gt
	 ZG+CBjbFzyHKso1MrEn1UNIe/fis/ETPs00L5uN0FKWa9/dqvcXwWXuw0GcdFH04m+G9+
	 20JG17SMXOcAKcKVRFqwhqsoO7+N2ElVZrFrogDCN9ediIazQe69MEzpROdCMleOQCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AA606A327
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 11:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 617AA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50604721c8so370135566b.3
        for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657337; x=1795262137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=MrTBjpIEXzsSZaANjc7oExJhwGnF+j3pBQoJGLV3AozjECewWnT/dOn8PoCfUIeYGI
         mRgldWBhVoyoY4kjpOu/TkcCPMpetn8bMN74Irqnk0JnK5MAQS777TE3iVfENO0qNvUE
         8qb82pxhdLikkA/6tATGUpByZMee1vHTbdl6A6vtosorr3+hE9wD/mpuH76lS1WAZqyn
         nUdTyabyG8UAyWqGnpYJGfY62DgpvBldD5kNADP5MARyaYxmHHJYDsQkr6qVKrnaldzF
         KHIyaxdpU8Pcl80WjVwUUXXw+yU81KD0D8RdN7wE6Dhf//BzElFXAKq/AgQBu3vGzFII
         7JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657337; x=1795262137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=WKLrUHXkBT0ZpzVZrd4/Xd+mBGBhp2nJjXgQ2QTxj0u7odSjSHXEOg2JDdAuDqVjaj
         J6yKpk74Z4jYBlT+6uAYki1BliXk7LvotZLW1rOss0kuRf7zr7RzNaASprXgNlqlY5l2
         PTKx31T68ULpQTvr3M4n9XIVYruBiGC6F47sKMawZRnqEhgmPbBsW8Hw7y58AGs5V7kT
         4s6Z85cN135ecsAoWSCm5aPukl4+umtKA06on2Lr0EDmrzsk1/APUPIcPaNm/shzbBTO
         SQ9CeiZoWBVd3Pq4vi8FgWwrR7Qj2vfasy444wC6JuIB0bfNmky/Xr21JJ3bcwwzT1Ji
         yHAw==
X-Forwarded-Encrypted: i=1; AL+hErEMU+wb8hcY91DXp8ux//uOIJuw9Zw5XIazgdtmmNUv4HDzgP1sJoA1BNLmqIFq1G4kk9FfCzXYPrfO49/LOGk3xxG2k9w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WYQZnhVtTL+1FH/RxXAveDEN8G+B+G/MWpeeVoHw8WHXB3zFr
	3eZQrIhhw9NLvaUhu2pSihvVhumQV9ZHBC0ecGnxxV1p1/J6ETtigisV
X-Gm-Gg: AYBFou2vAhbxF0aP50UKt8ylWogQOHEBxn8H82/K4aPvXB8SHuI/EMZh1tMLGTfXBMe
	TxkQeZ3sE4z7MLr7jobdFAMBxemDDCWnlPpU0XnspbTI8zl405HGcIaQb3u1n8JtNOy5JzTaY8T
	THrDx99RC3fQj6HMEbcTuuvlpT5caBgIHduDvSip2M12CV1IDaXSRIgrvPR0BLd+1PU969VfiaX
	9mBGcu1GkunrYPr9FmReIBInk3Qe0fsAlgwiWkc3TmKRfjDvI05M5qpYmJXo1/Y6kbUBp9S6fLj
	rYvpuZLSTouOlJbcuF/bLH9rnCazRH1Bfe4+hWZ/X6Gv/WUE5jWo5Ed60PSbyj+qmmYwTCqKIF1
	m+wnx14s98DyxML58Cs8T76dQqzSYKAuWd4a6PhZMKd/D2bEb01HUlSjfjCj3RnMskFI6GhpFVo
	Xl1VIXFHbiLDsXFHNNyB80a7L16c1cGKmFUwfGKJAjF+eEDu7asuGlEtzxiVgb8PgdwvtfHjhav
	ez9ctt9jZIhralyzTg4vJ3QF7MlilxUXZI7H4/PbLGuLUp3YTNSEP4BMxKLoW2kwH8dSYM5qKVZ
	Y6xC62IepXPE4l4Brazq8eO01Xgd833jjyzZdGGezzOgN1VeDaSMrEDaJdBzWq1/m0o65PWqD/0
	+jF3YctbB9NM=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id a640c23a62f3a-c5096370c31mr441592966b.16.1794657336589;
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b41f44sm206223866b.31.2026.11.14.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Date: Sat, 14 Nov 2026 12:55:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avhMN39TECaur0sS@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
 <20261111151202.GA11391@lst.de>
 <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>

On Fri, Nov 13, 2026 at 11:25:57AM +0100, Alexander Mikhalitsyn wrote:
> Hi Christoph,
> 
> On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> > I've seen setups where people use fuse to mediate access to sysfs
> > sysfs in odd ways.  No idea if that's still around, but if so, this
> > patch will break it.
> 
> 
> Oh, that's painful. Do they use backing files for that?
> It's a relatively new feature in FUSE...
> 

Very unlikely that they use FUSE passthrough and if they did
very unlikely that it would break their filesystem.

The API for fuse passthrough is that the server requests to setup a
backing file before open via ioctl and if ioctl fails (as this patch
does) then server falls back to non-passthrough open.

The ioctl can already fail for many reasons such as MAX_STACK_DEPTH on
procfs as the commit message says, so server needs to cope with the
fall back.

Thanks,
Amir.
