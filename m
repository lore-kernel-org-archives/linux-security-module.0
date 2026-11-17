Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904513;
	b=D7HdrEQFks+HtQNic9BmKgre6BuaXT6ZhoRxFsbQDshoRrk3i9BaiPSIYF2Ta05bf6dF
	 BQHP9k2Vg+Lk26MEFNXmXaUqhsw5KsbxokmAstK6BXaVg058fiFLXkxpspZDYuD6M+LIj
	 Y8Ft7YjmU+GRBAwaccGBki9jKgBwJYc0f4eLKr+G2eFfsfRQplgk6an4QOtwrKRu1glFT
	 jzJQxkQ3Kkae61Uu0wMSQ+riTtFc2swaNd5shAlw6j9nvhzscSJMt9Pa5sikxB3euZHIM
	 gz1PPxm7qdyQGWqAiXbZcu/K54naz1TbvCh+1JQ1kIB2O5ZX2ILUm34HReG6qbFikfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
	b=QDv2OVFejp2uvTsPtUZX5Hja0jXcJ74phsUeK2xGZ9qol4oME3TbSDIiVU7OjTts1d7W
	 GsSRweq+tsSb8H9YQmQeA+hZiYZbNX7r21NJSbn3KcyrAFfvKxkfRaRw2S6TlYW/dqcgO
	 hJbzRMRxvYB8ctjth86h88G2MFFFk5VouqsSHzQP7gwJ2G8ukieDfMFDnazU/wVqhk220
	 3/C15wau+pcwkLfOhlEHlEofIsRXtcOrp9ufErXu+kPHme8Nk/eSwEF/8PasaHz9kYPS6
	 Ow8OFu6oWGRevTybWyc+96lGjgoXfim6xAqSxJSvcy2dcejkjl7PMVvykrtkkqIoUxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD98606A8AB
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BD98606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso581582f8f.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904510; x=1795509310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=asHWLUHh9Osx9c7ISjHVvBK+jrwM+bEKiKQ5ZLUG8jHeL8cbDrdmay7aq+azwtlrvN
         q7YkHw224WJQO7TnM1AyMygFYXrlY29jKpq3C9XROr0oTqsA+UK4p+WS5GMy+xx9DTRb
         nuDA+OEO8+ykjkDq/RDjAwEfWgenycj+snq2KkG6mulygb6NKchr6plM71+t8W0/+aGL
         LigMC+giRqQ92TsunABClmE52NWQSdRqhQeez7lH76lemvGh63Ic8nud3Qte/9KpQmbQ
         YrdviXjfG5hlS64KIE7Iq0kMRVYmtZMNK2hkMRb6Cz1tihRk5N+J71aJKPK+K5E0SOED
         KbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904510; x=1795509310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=GbnrSk+fcpIr7nFNTqhMrU7x06Ra5jLRlb9CEyP64OtAWz1SYn2D9Nc3USu1U+XA/3
         1z3V6x3LFnHdfOAEQr6DQAck+TH4UU4FYMue3S/QCDFUwtZBZoMkVp8bs/FDqs7RvXnU
         DXpFDPkV07M04ghbKSEsKo8AffFB/ivI0LCXklbI7XnXTcqBkGo7HKLoDy2REbBy/uOh
         5wcoJiVgSnCsiNU2d/Wsoql9fDA/vLZERMperdTaqB7nRvfiPn2Pxg1OCNuoxcB1aAJp
         S9IJmaLTO6mxMNct5Onsk382jmDN3HMNeGVSybkNbipyE4gEnM31PG9M85J3dn2DRWIG
         hOQw==
X-Forwarded-Encrypted: i=1; AL+hErGGWj+5osOS2SR1dFTyvaeWbJUUUaqBkisgbe+JDFR62TeYsDFENHhE9kcJZMMiB2N46B5dwhCVi35sUsMk08P2vwndI5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Dh3Rs9pcbAaveuIcmOf32fQHRcy63Q2znSlUDGM+PlFOW+oyz
	7NOCmXAXHpfQ1Nq3haMG2dzlG/UE112UWus7Az8KrFPNOWM/MmQo1GzEImqkI44QaP4O
X-Gm-Gg: AZFdTZeG3Hx4Y8FEiq7c/nBg+cWKU5LRDLjhyFK2ys4JMU1EUwFsJpCj7ocaPiJKbyv
	ddygXVZgpEBKbg1toYG0xGhP+ALnpnIEiL5wwoafyWgMWFQ04cFg1mBjcZlD6pmPTsgctgoYNO8
	jg1IV4EVNL9vsDxLMruKSv3mTPvauehcPnX2JkZke9qlzM/JVSJPi/9hLilWGYqIx/pGCoqzQcW
	U/lsuWLkThtwfukMHv6ZpqDCOTXvn/BhyWi50nI4QGjUOqRC8JW+iDgEyYXfxiR/TisGeBF6RSJ
	TXMvX7vzL5q1lUivHaOL+IgLFRf+DyMslJZ+18EQzdIl45ebhZM5IJoLBiZyJkvGKsZMAE2hxYc
	hCI2EFh0q3um51y79e+cLF64a2EOw0B6Izwm4fKYyZBf/J4tiAD6s+PuhNurdhjkJBjtrhPNkce
	dDAIU9Ht7lnFp1w9dG9qpzr8sQ1OHTnp7U8BR91kjQ9xlRkVUvXZMMIgIBfDJDtxu5yiIl39ddQ
	uz4BsZ0FYEJJiqXCSJKEa48AYJ70VVTYZuX99mOMrRMwBGua9PgCFQlPsjAj3R8rsV+0E7aOupe
	DQVks1MZaEtWvPbeliWyH+lQTTiFLs4MelhQjP7Sihe/ZxHv9Jak+DpVBNXhn/Ui/NLsPg9Xeo9
	/06F8lRNjPhlPXc23HgpKtfsKjLHwEO7Si6YJT5VfaSv83olrGfvsHiyQ
X-Received: by 2002:adf:e193:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-49c728c6e6amr26569239f8f.43.1794904509932;
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm26338505f8f.36.2026.11.17.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Message-ID: <b0ec2cd8f9b7a6a2e4a54c6df2fa897bce068cbd.camel@amutable.com>
Subject: Re: [PATCH RFC v3 28/44] ocfs2: use fc_init_pseudo() for dlmfs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:35:07 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/ocfs2/dlmfs/dlmfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index d3bfcada3e3bf..1789ec96dc130 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/slab.h>
> @@ -563,6 +564,7 @@ static const struct fs_context_operations
> dlmfs_context_ops =3D {
> =C2=A0
> =C2=A0static int dlmfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &dlmfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
