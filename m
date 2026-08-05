Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2D3D333D
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965831; cv=none; b=n5I7aawvwVU4S4AM4DCRXESy3Iuq8vWveB4V3obJbnE4psM0Gqver+M/PJ3BUaBLmbil5yReaxQ6ZcYCg7mZdgDV+DMvv5I1VjFPYZbKM2NfMfIF/CLZxc5aFNcoU5jsAKkRfdyRWC1IkCNltPs5P879weQP6dej4nfKBXCZfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965831; c=relaxed/simple;
	bh=ybn3edS75210yGXHR8plER5wB6+bwq7DsJxlu+7rHU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQbnB9rGbKvxVtoNlXkyl5+BvMHgZeViBBgkrFDv9K4EpGrmAPAHdmraiFJWdCikDrDVdSliqMGrR7tyiLL4C/ANMuNaiKwaKHG8my9rhFTztaL6zaAqBe1N21QLmdwwn8Rf84HaAdQ5zSfa7I4EmYE+/hj9pgQShx5PRG10/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3QAhSxu; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3QAhSxu"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66899c7b57bso2024774d50.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965829; x=1786570629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJ/f/QQNT6OWCbAu3IB8DxQ9ZnyppnwIAD+QIRJse9g=;
        b=Q3QAhSxuHwF7ThIMUDCku95Bjrooo3TnufEF2rcHFZ+wuvrYOiHwkbqZ1HoEY+coXz
         t14yH0GezNHRgvxBa+xE7pt3tmn/QamWFuad4SvsRCMsa8/PtKI5r9t3GkNGLSBdaOlg
         UTgA8AdytrBwtXeUWNueYCuez+ZP0YUzeRxpweA5dRcGQWGfXkBHxr9h/51vRw0V7f1w
         v52TUIBu7GWrdPpjU3tEEsjG0+2tm3Rk9yJoZKifXM50F5/IyH7hIfuBHPhPpsfPUDlT
         Qk8/SdPe3eb3Eg+J5i/e6wYyyNkqOtGCn1SgZfk7L8+ZbkdfxgLxzvwqPMjx2B3SqOp8
         YW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965829; x=1786570629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eJ/f/QQNT6OWCbAu3IB8DxQ9ZnyppnwIAD+QIRJse9g=;
        b=peJzuhcPWk/PrRkayOPiLL/yOi3aEBt0l7J9OpvRvgIZDXqFdUjve75ZHJA1a79IXe
         dc0skyrepGHE6GGmdSzB3/xA2Z+jsU9OOdrZgiTI8a/kHdTC0T90q99OzLfqGQKAKcHm
         CY2LwzjrZUg+oh2AMYpzuHWBv8hpY8GWvSTqCHEkZPqMeNj6VvrKxB6vp7QNzve08c4v
         jw2m+/HucNNt97Qebb03U72THzvuiFYCaL0WfSUd5vZdw5T9iWFumdtHtH7qhgAk8mO2
         dM0G1i4pdNxy6jpGCPoTaHtfSabOVgdi3ZbLnFZx+LkBsat/yd1mL6KE/5zE5VClbhdR
         NLEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZhC7DUOZdqtFwuJSwRbVlgRvqYe8lSPgxpnUBOc3nfXRJBQ4hJuzdvQHBuTY1KGsdHsfhpA74wD16JLCjCxcod0GeUQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Vkp59F8BusPviHAeS3C5AyppY57F+LHU0SBCC9IpCunNCf8q
	E+ArIbuyML5FDJBz+BR0cv/xx+1OUb/VWlKGKPmfz0PeaK8ilp38YM13
X-Gm-Gg: AR+sD13god+8n2SgoP/XbyIsLFe8bOILOc8Gpr463qJkbsVNzrjhFKlOdSDBtnWFJx+
	2c4MZ+pfAY9ShoWLTEtfjzHdGiGzMvucRzp7A2qFh2FVDSWY7tYVlEQfEfmctaj9+k1LWv/39aC
	S37c/kT02iYSYr/X9M1MnQKSOLf1kaPU4umAIhhfSrjF/sCSfTRWrf2LIm2mVYmYXMwCOEVU9DK
	Cv1W6k7PrW6t0P3JmbIB9ATgRMxtuoWiIJ7yslv0yVRq2q5cKqoMyUpbzKL+7p4oACFEimh52x8
	mRVEL05ge1MCe6a9Uo72Tjit7CxWfDE+oxL62Kpd0sHu9m9vr67YLwpYen25HpJaA2RZhF5VUjG
	vJ+r8hwUq+ByqSo99g9usCGr4o0eTTVSp56Klc6/Fv986raF830a4+jm7Ws/xd0BmgtHpabCzF7
	XbtCfTvTDX4d7JxgwFkuEfULVaqPJQWAWNFj39ov3LO+hD5aYD9eIX+M1s44ItxbILLy1iRC0n9
	3gvZv7zXrD/V1NEZ2nBKdlpPpXhyuGhDw==
X-Received: by 2002:a53:b427:0:b0:667:9d0c:5b80 with SMTP id 956f58d0204a3-6699ac4ef5amr4215598d50.28.1785965828960;
        Wed, 05 Aug 2026 14:37:08 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:7d5b:ac23:cde9:3664])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669915f5a75sm3862542d50.11.2026.08.05.14.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:37:08 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:37:07 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <anOnaGmBTlBW9xwj@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>

On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> [...]
> As you may, or may not have seen, there is currently an ongoing debate
> regarding the location of LSM kfuncs that will impact this patchset.
> Sadly, we don't appear to be approaching an agreement on this issue
> which introduces some additional risk to this patchset.  We'll have to
> see how that ends up, but I just wanted you to be aware of the
> situation.

Quick aside question: Would security/bpf/ be a better place for these
type of kfuncs?

security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
for kfuncs dealing with lsm-specific types.

One issue with just security/ is it's not CONFIG_SECURITY_BPF. But
security/bpf is. Right now security/bpf only has hooks.c so it's free
real estate.

That way things are more greppable... (important!) and we can have
proper MAINTAINERS entries per file so emails get routed properly.

(linux-security-module, bpf, and whatever lsm list)

Justin
