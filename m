Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769946;
	b=Mo8zwtM4h+xFl/JGFhNphAmnziX4WHSt7zqmYsVhcJP4ExkouAXHTzSOSbsI6S4B36zY
	 XWNFDbvZX+EgenBeXcxQUXC/RrWMWejT9OfUEKCHM2Qul3A3HdoR5u710J1d4037VQBw2
	 tNM33yuHNf/g/07aA54u0BcizFHq/rj6r1R8PGjSTK6J8qaIRb99OMEJNUix0wkb1R+aX
	 jRPGsWnSFX9hTxjT4Jfa3fLRASd437G18SoLzje/6fTmFJU+Jeo2J4JO+Z2T8gQKtq1ik
	 CBhwNwawxaPl8yOs2QxIU+TS5L8oUCwMPY86rYJap1ao8PhiA7s0YkqaavYw5TmTnNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769946;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5XPxjYP84J5qtW2J4U30RzKiijCCUuN8hhLODUHRDy8=;
	b=fLHerWqaPhqwxIxduqh6WdDxIrICNk3dN60ckuAfNrVRM2T7HX7QJauT6cJa1Nbochf2
	 ZT8c4g5GH4X/sMVCyg8zge2/O2/XPOMBjTcNjk0ifcBbhYwvD36/zHwMhbChaynSFBiB7
	 305P3SGiIes43egWxc5zNt8j9Q5T9UohsvQubLm00M+0j5Ms0N7nVXl9OXu/czyCiB1nW
	 8+chNww1WxLXjn3asGWImONRZHi73l1tseIsaKPjrmD9ile5dR01/zFKnJPXM/hHhXgmd
	 fEHsN3omDEGLJulQRCEcb/pfBJcUvZfzdw1fknIo9BNdu4YfDD0U044ByUT1Ws25u4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	dkim=pass header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=ObQQUMe1;
	arc=none smtp.remote-ip=91.218.175.11
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82926606A31B
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 15:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82926606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=ObQQUMe1
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y1dlIOjwh5FFz3HNYQ0e2sREZLIjYAXBLkpbKMlVqBA=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792769943; v=1; x=1793374743;
 b=ObQQUMe1YcuLd1jO8u+3kj9hrSyK3XKg8wf67pRzbbDmJI601UkPvlg5bL5ZGtUItaHdVgpJ
 qOuNnc/mG7UZuCQl5jhodnz44lLN8KqJxJI8ZORAXMQHM13xNG3EwHAqTj0mu/ZZRfupI6nlrpQ
 2jCNyJCoNHatnviz/HpK/ZgcWrliL8Mtfg5qqD8uM8ym59TioyL+neEyLe5v4UTjIi8AX54SiP8
 K/FLbwwxsFluFwIQuPCbxxYLt4otTUUhJRTvzk5pkjpsP8OdZUn437SkwgneolTK4noc5t25u07
 V9bTQiTEq5ZrccXcsxdXrfr4NTPl/OWCSknQW2qnzTOgA==
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea7d77c4ee75b1ca;
	Fri, 23 Oct 2026 15:39:03 +0000
X-Mizu-Trace-ID: ea7d77c4ee75b1ca
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 23:38:59 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Fan Wu <wufan@kernel.org>
Cc: Yan Zhu <zhuyan2015@qq.com>, alexs@kernel.org, si.yanteng@linux.dev,
	corbet@lwn.net, mic@digikod.net, dzm91@hust.edu.cn,
	skhan@linuxfoundation.org, gnoack@google.com,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 09/10] docs/zh_CN: add LSM/ipe Chinese translation
Message-ID: <att_kzD41pBMHw3O@wyuan.org>
References: <cover.1781105672.git.zhuyan2015@qq.com>
 <tencent_DADDE291CA580302EB7BB40B83A552D6F006@qq.com>
 <CAKtyLkE3unhxMsH1LpqvjHQoKVgz1tcTsZWUxNHs+R6v2amf6w@mail.gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKtyLkE3unhxMsH1LpqvjHQoKVgz1tcTsZWUxNHs+R6v2amf6w@mail.gmail.com>

Fan Wu <wufan@kernel.org> writes:

> On Fri, Jun 12, 2026 at 8:59 AM Yan Zhu <zhuyan2015@qq.com> wrote:
> >
> > Translate Documentation/admin-guide/LSM/ipe.rst into Chinese.
> >
> > Update the translation through commit d7ba853c0e47
> > ("ipe: Update documentation for script enforcement")
> >
> > Assisted-by: Claude:deepseek-4-pro
> > Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
> > ---
> 
> Have you tried to refine the AI translation? IMO some are really bad translated.
> 
> Also how does the doc translation project work? I do notice there is
> another IPE design doc translation,
> https://docs.kernel.org/next/translations/zh_CN/security/ipe.html
> which has a wrong "original link".

Noted. The recent consensus we reached is that this field 'Original' may
be removed soon.  If not, I will send a patch to fix it.

Thanks.


