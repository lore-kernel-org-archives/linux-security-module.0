Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792391;
	b=SpuvG4uYnkRZpQTZ4ga/pBEmuC5LIA9idnNgABk/BXJmmyDfHlwDDVDCbXUuerITqzX4
	 3jg5o/29PPCZVUXOKd2og6h/5PD4oIblbEsDsWHrT5bTxRkVb+yJLcmQiZygPb3G81ZaY
	 mSxY8UV2pDYKwa4KcfGYQYi0Z06hJgHbozZUz2wt37h/ZF3Pt6MxM0BEvw8yB14hqsBHZ
	 ISjoVI1RIbmf2/iO/0zYTaBtA4Wj7+IesoUGMw3d2kjoiqEnPOK11mFqwT/EEOLyCNjS6
	 ZvHQeSSOkp4Gw+5pR+tOi0EMGWMwQ5yjm8atTcG2sT42TMQeJQPozeYp02ZlWwulClw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792391;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=McGfXmMsJaggyhVO48JgpkG8UhfhlryUQ1Qrm70nqEU=;
	b=1jKghRCQTeK/VzMWh7VnnGaGbVY8lIKWUoXi51OpmNyQYF35GRZHqVlzqSepmFxY2tNx
	 hMbzwEUfRjgzBneDP5LpsWp8Ao2yRsqTaQob0zLiteuaQKuW3xEibl83F3y9WeaWnwJFg
	 kZ/fLuk5IRzLtyn+duNx6yUV2dK8ZlcXpmloutLqGRgiBCKJR/ONYez01z/Zj04OmVEVY
	 KhBrBRbA5Wtgfda7YMUZIcGE00UAfyoD6rxl4ntKTDZqDKGWhkSnumIKK87FiFWPE+xmM
	 ogG2vIMMPbHdZppTWCEq4yemzSVuJUzot1IL3Lot0Yvi2qGJxSLq3/LcnXggj8/2RhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	dkim=pass header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=TYVUZyWY;
	arc=none smtp.remote-ip=91.218.175.70
Received: from mta0.migadu.com (out-70.mta0.migadu.com [91.218.175.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E6606A31F
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 01:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 895E6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=TYVUZyWY
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Je6nTw8zi192wQHqVmmlQ+aCYBg3ySVT0Qp8WfigOvg=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794792388; v=1; x=1795397188;
 b=TYVUZyWYVW4DCPoF5R+8JOGHM1He23YYI0ZUQEepkjqRRLQ4IghlK/euN0903joj5SU0iWjv
 t/azqlxaD24vmul+O3SdYTCRhZ4Tpn5Rb+UupOgWbAm0zoRAujKxOYHew3YZ5cn1oSHxAjYRGBm
 19uvlSbH6O7HwGkiTCy6s/UGGQdIBv6ypERKkeZTsyqxBrx98luYCS+bUGJDEFKSfHXkfbL4Ifi
 OFaCWhH3DzNWZixxOHzJTcdUDUeuaQxjdyJNLfCgPUkyeeBbWDwYzr7lDGOvedPcbzA/x6+ET17
 7/O1j1EgbqAd99cNBD6PgU1f329zXvdnx3YXMG9HlexBA==
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 329f468c44690c3b;
	Mon, 16 Nov 2026 01:26:27 +0000
X-Mizu-Trace-ID: 329f468c44690c3b
X-Migadu-Flow: FLOW_OUT
Date: Mon, 16 Nov 2026 09:26:17 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Yan Zhu <zhuyan2015@qq.com>
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, mic@digikod.net,
	dzm91@hust.edu.cn, skhan@linuxfoundation.org, gnoack@google.com,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/10] docs/zh_CN: add LSM admin-guide Chinese translation
Message-ID: <avpbuYL51UHpbAA_@wyuan.org>
References: <tencent_5E314704B7770A972FCB82AC81BB91A39307@qq.com>
 <avpSNfL7FCDVyTK4@wyuan.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avpSNfL7FCDVyTK4@wyuan.org>

On Mon, Nov 16, 2026 at 08:45:51AM +0800, Weijie Yuan wrote:
> On Sun, Nov 15, 2026 at 11:19:56PM +0800, Yan Zhu wrote:
> > This patch series adds the Chinese translation for the Linux Security Module
> > (LSM) admin-guide documentation, including the main index and all ten
> > sub-pages: apparmor, LoadPin, SELinux, Smack, tomoyo, Yama, SafeSetID,
> > ipe, and landlock.  The admin-guide toctree is also updated to list the
> > newly translated LSM/index.
> > 
> > The original English documentation was restructured into reStructuredText
> > by Kees Cook in commit 504f231cda56 ("doc: ReSTify and split LSM.txt"),
> > and each sub-page has been kept up-to-date with subsequent mainline changes.
> > 
> > base: https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git docs-next
> > 
> > Yan Zhu (10):
> >   docs/zh_CN: add LSM/index Chinese translation
> >   docs/zh_CN: add LSM/apparmor Chinese translation
> >   docs/zh_CN: add LSM/LoadPin Chinese translation
> >   docs/zh_CN: add LSM/SELinux Chinese translation
> >   docs/zh_CN: add LSM/Smack Chinese translation
> >   docs/zh_CN: add LSM/tomoyo Chinese translation
> >   docs/zh_CN: add LSM/Yama Chinese translation
> >   docs/zh_CN: add LSM/SafeSetID Chinese translation
> >   docs/zh_CN: add LSM/ipe Chinese translation
> >   docs/zh_CN: add LSM/landlock Chinese translation
> 
> They are still confusingly threaded, and you forgot to name them v2. ;)
> But anyway..

Ah, sorry, not v2. If no changes since v1, then name it
[PATCH RESEND mm/nn] or similar.

> By the way, the 'Assisted-by' trailer is no longer needed, but the
> disclosure is very much appreciated.

If you want to remove the 'Assisted-by' line next, then it could be v2
as well. ;-)

Thanks.
