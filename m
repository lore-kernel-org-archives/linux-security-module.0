Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AA477E39
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198095; cv=none; b=nYXL9q4zW0ho6qZP+7mM+GxkFlvPQwLYRlkiubTwSwTj58JSdSi7vHgQm3YVpI5L66ju5ZHslQd+cZYitH6SCS9EZVfq5aKyutdNmwZ1JPLvWl3Obym1wUs00Wu9Drc/o9FPVPqXa0I5GndrMMy339HZY3uBOyloInndDdPo7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198095; c=relaxed/simple;
	bh=C/Rz9qm1AS7WcIJwDp7Kv3cwkoR6F2w0jDkOHOcFIFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGtb8a3bgLKDRPtbEE/o6/xbmyOwO4wyR/mFXSX8QGnnTlVmryd7tYZHi4gkwCJcQh0QqICVQSOtO2arUO8MFzhv/7lvqAdiTv2vbM1IrJCunqYqRTMV5M8hSuy4cBokmiL5oczKgSA81E5ntjUFAzFexPg2sWIgKeJ13DBibWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/3gY3aJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/3gY3aJ"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e6a434cabso656585a.1
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788198092; x=1788802892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gve2pugT7l3BMYWVMzhugMxNXpv/Y4BKioJOYqJB6Is=;
        b=H/3gY3aJZjb/853Y0ygGssCvXexBNV7ijQaHpGAfUzoEZkuCUQHwyTuqBigVIvUjz3
         jU5zRsdLKMa5OpLORvfvdNuUFCuLG55mu2A2/YEugk0Jf7UCtqvE7IRNH6O5sLLlfIrn
         P+nVPPvGujofLsCvBLJd4YJy1BES4qnyjspmgsOrVhO25rrG9ThK2wxo/6pa+nHc3AWc
         4+U8AyqJ0AcYf8Q/+P33Fa8yHo8EAU3Fsw0WiR65EHWE5NNysHzIz/LpRIm/9j8zQyzF
         9n7Y/wJibiwY5oGUPAR4EsAeJgWf4gpfIkhiHnJFsRyHcATed2A1N8Loq5OsjVtshyuk
         /0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198092; x=1788802892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gve2pugT7l3BMYWVMzhugMxNXpv/Y4BKioJOYqJB6Is=;
        b=IT5QnPmJBIzII3RCYXVU5pCAcnLlKKLQ8EZZL2QEjQYHuNgKyGU2hJhrGSgZ5O4mbE
         VylB8UVy0vU8PoAj41lc985PJI/1Ja3G6IVuZ4Ml9PTYAisETZDDOVGvJcpBsgI9BSJH
         JEU5B6J7UOohUieJKg0Ju1MMBsHutmo+ArY6s3OwfZxqZ/nc+n5hfReOMI0KQHsazhQT
         BX6tpdmV2yb3CseE9PvKUptkWj0TM5JXoUPu9R3/tbRDXin/PWbosdWxxeqmkWYRI1OK
         Rp+ztAsQ6/yyKu/xkf3CaxuSRnrpFPPEfACv4KhNNb+Y1JK1f/Ba8kkbuYKVmn5/0nDi
         x0Lg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8VVqqOs77dHMoR8CKcOzWcZLVNBvbjgARWxS3SvhCvr9PbnAXlSL/lkVauVzmHD6g+F7fmZMwIqI7LzCpfc9ZPGq2U7o=@vger.kernel.org
X-Gm-Message-State: AFuF++kzj2a53Iwfug6SqM6S9rWh3dncm6RrzRzL3VijF9oA40j13flj
	KaXwTn1k9hA0p6kKspEmLd5K8e+tEGmkQvmVj7LgW0IK1eIF4Uc4bHQU
X-Gm-Gg: AR+sD13MQGyqp6RAbqnHrr3pb4Op+uczI/E8l7xhR+vJj12D9bl3kIS8gqVk7uwNlcQ
	XoobMo0Xs49OFDL7IiwBZKOSvUvijvQAUpDYyTzoxau4cT4XRGT9Thu2Kx51aTLf8FWYJhoQ3CB
	QseM1EZxMN7LXDPAsfcMKYt8g6tvTevVQz4OO8LZ3AvkbqG3sjTSPwpjId4aFYrtX5ERtlFLyBW
	NeihWX7yBwRrtHFE4A7mFIl6DBO6GsNnJfVR+NCYWILO/aE5fNYC35HUU/TV2rQ87nklZbTfhap
	SSEuRiQ6msEwzcMCbPIDGNDAuELxH2qmR2z5Tl2indteZTOpBP1L6sSpjjohDpec2B9m1V9yS5T
	b4uHHb7AyE+DKP7xEKtEe1os+Ga6jeTaa8nSbbg17x0pak9zlRtSTCI1ZS4ob9sy+YbeSR9UZg3
	+XIgVjSBh/YzvMiFinfop8WKwNC1MIesPU027rgGmrHb/h3lBzlYYDpeZ0FydbJueblq0lrl6um
	GiT0ySjnExHvQljswalIwJM3GLANAokSQ==
X-Received: by 2002:a05:620a:27c7:b0:930:a635:a782 with SMTP id af79cd13be357-9391380cd2dmr3621041185a.11.1788198092300;
        Mon, 31 Aug 2026 10:41:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce444e76asm89697106d6.2.2026.08.31.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:41:31 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:41:29 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] lsm: Add the LSM policy object lifetime hooks
Message-ID: <apW7yi06EutRfCBO@zenbox>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
 <20260831145858.3869191-2-utilityemal77@gmail.com>
 <fb9ee5e1-dfc1-460a-85db-1f31f2f6ed17@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9ee5e1-dfc1-460a-85db-1f31f2f6ed17@schaufler-ca.com>

On Mon, Aug 31, 2026 at 10:17:43AM -0700, Casey Schaufler wrote:
> On 8/31/2026 7:58 AM, Justin Suess wrote:
> > Add struct lsm_policy_object, the identity an LSM embeds in a policy
> > object it shares with BPF programs, and the three hooks managing such
> > an object's lifetime:
> 
> I am not seeing the cover letter for this patch set. Are you sending
> it to the LSM list? Without that I do not have sufficient context to
> comment on the patches (1,2,3 and 8) that you have sent.
> 
> What I do see has me quite concerned. It's possible the cover letter
> will addresses my issues. If nothing else, I assume it describes what
> a "policy object" is, and what it's for.
>
Indeed it did get sent to linux-security-module, it's up on lore as
such.

https://lore.kernel.org/linux-security-module/20260831145858.3869191-1-utilityemal77@gmail.com/

Possibly got caught in your spam filter?

Indeed it does provide important context about lsm_policy_object.

Thanks,
Justin

