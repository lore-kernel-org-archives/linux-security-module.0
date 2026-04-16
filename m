Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B736C5AE
	for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2026 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376390; cv=none; b=dySUjMOQcnLUZPtzGnqhQD7dUsRrOz6rNAdOle3wGVjeUAB3gTGI9gc0KmG4Snnv/gNlZ4Lf4A4On8d9dwADKlOrOJoGWTG8MaHELM6ej84lJ9qPhavzlo8UAnzkcGc5YIfNT/PjxphssrpH4ZV4gU46X3lu0pdu2dzkpgf0ri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376390; c=relaxed/simple;
	bh=fc57u1ib7joGvCNK5PYX6Wm4vwMtVJPQEZoKGdGJA14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7a/JvFqw+eP6KBy+BjCLjdnXKb5gUUfpZO9ED6J7iabUmbSq6AMvywJquprKfvqXZz+W8uofr8oM4xxFTqgPcUWr24egF+2AetNnfC1LxFUgLxYjfYXQ50pR9z9Emj3ge8DsYfXeBah0E4zpPketmnO0pn9zy1umkuKvsp+9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtIO55Wh; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtIO55Wh"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64d5a7926cfso73398d50.2
        for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2026 14:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776376387; x=1776981187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E9IBe90RbHchIfC+QQ+bgmf2ghgUb9RVdOaY6yEgPS8=;
        b=BtIO55WhzA9HHFLI/Ew7CzQHJdbeQHcdgZWEKdIxLpeJuaKX8SHcuoTeOdFkx9R+pI
         aLwIk3NuCjsmOi/BfqmIQTTWYfwiw5jtOBnxNvsQ8QROq8V5rER2Bp6ro1eCcK3DjLLU
         ODNYwIc2LCd6AgOQQ8j4qpHc+pLoGFu8woG0ZMzK9kTTHATwsBBUOD0qbki6kcm5LC65
         Lyr1m7meH1tICVKDUbzUpppvLIuseCdJMUbWIsDZKBDs2QbISF+ckg74FkvNjibmp5td
         GWNbjLh9SlTTNDz19KGjFMAbWKsxZDZ813iCSlJ+9Wbj4lCldzY0qIBmc5lM+pgS8oT4
         ZfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776376387; x=1776981187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9IBe90RbHchIfC+QQ+bgmf2ghgUb9RVdOaY6yEgPS8=;
        b=DNexU/bLfLBo5DTA/O8GZGThxIQRPCLp+TmKbpzBvu/UkmJGZHxkHvNiErE+kXuPfA
         Va+dg7sJ6nLYr6bc4Y9j0Q7BQ68P0/otQnWxwD3X2bOdnF1vBWxYx7DxFm8mEfuLVpBI
         Cn0J/gyk4lQ03dyIvAkZ4JhyFeKiH5Th4+AcOf5yl/OKAVbYWlam823eG34NzNn/RbnD
         55cCRf9OuMtQwgOA7In7EI4H0F8d/gOcPJ8Q4yGyYjIrTrXT8uUA3vorFxdHowojsUVl
         kSXHaUdVuEYblYD9YXve63/2/R+fN4U0DyxAkxWtsjpkcXwwn5U7cB6vfyJl1oVlNIpn
         FeIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FM+B7RkdpOQdakHZBYxUxKmNLSIj1j+pPK80BgwzTXj7w1l33tq8taHVf8rJJQNtKS5zmItOGUYpWOxKVnXYTgKhGkB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2MbMyCmZ+9k/1n1XM0swPTG2IEB2BX/6XN7FP3Y9bCEaZDs7
	M//6cfDtHJPyzw7PYHSpcuZ9ifz2sayO2fT08MmOOGnhuveK3XBgR1ZG
X-Gm-Gg: AeBDievl+M0WJ9PyTyp7Cjr4r5lI2NzpieG6jV3whQC7c+wvQ38RtGI/jbbsc755Inm
	2SfTUrRDI6h7D5OmtJBC5HwnKMlcbkXFqcWd5GJEoRPD2kjQAzOP/n0XhRYFti6awlsuCNsHyCt
	DjaFQmd6+iNfWw5m6SvRqmEfpkFzYgzw8c7wyG01++iNPEYLCUaTKk16tY3VhAYOLflmcLHOboQ
	rcy69FbGghuEfE5pNRafuToTTBXGO95UuVOoDb7HkmIEToV2jJJztPI4Ircv3jOMDraiT3ZbPyM
	DPXhwEUcr0qUeUTGKCYdDD2MPOJCpoaP2/X69M63wI5V0MeP/WdF/2rf2XisKQedEcE/0nQnPJ7
	ZDkXyfRiuZ+8hLPiCeTFMY7fW2PSVUqxU3Ovq8D0S6Yk3ly3opM6RnoD3dD5FF0jNUaZxH+wkmW
	oSz8KtPpn93C7K/G3A6lYZxTc6WVM3/GAT9eoQMMvOxFBJBBz22NpCdutDNXK7fqkkJLXCPLa5q
	gQ=
X-Received: by 2002:a05:690e:140f:b0:652:541e:9689 with SMTP id 956f58d0204a3-653107c0003mr474357d50.13.1776376387423;
        Thu, 16 Apr 2026 14:53:07 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:9b9d:98c5:f23d:1874])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-652e44c08a5sm2538380d50.1.2026.04.16.14.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:53:06 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:53:05 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net,
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org,
	gnoack@google.com, jack@suse.cz, jmorris@namei.org,
	serge@hallyn.com, yonghong.song@linux.dev, martin.lau@linux.dev,
	m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com,
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Message-ID: <aeFaQXkKNHFeE-oC@suesslenovo>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com>
 <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>

On Thu, Apr 16, 2026 at 02:12:11PM -0700, Song Liu wrote:
> On Tue, Apr 7, 2026 at 1:02 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > Expose the new BPF_MAP_TYPE_LANDLOCK_RULESET via headers, allowing
> > programs to utilize the map.
> >
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> 
> I don't think we can introduce a new map type for this. Instead, we should use
> existing map with __kptr values.
>
> Thanks,
> Song

Thanks Song,

That was one initially considered approach.

I initially decided in favor of the dedicated map type in this RFC after
seeing the other FD maps for cgroups and sockets. 

The main complication is rulesets in Landlock are created as file
descriptors backed by a kernel object. In the intended model of this
series, creation of rulesets is is done in userspace to avoid
redefining the entire landlock ruleset creation API in BPF.

I don't think we can pass the FD number via a map, since the FD is
process specific. And it needs to be done in a way where we can lookup 
the specific ruleset the FD points to safely.

So we'd need some other way to load the ruleset from a file descriptor,
either through a new userspace side BPF call or similar mechanism.

Is there some other common pattern for FDs --> kptr I can follow?

Basically the pattern I need is userspace must create the file
descriptor, BPF converts that FD into a refcounted kernel object, and
even if userspace closes the FD BPF needs to hold a reference on the
underlying ruleset structure.

(In this patch this was accomplished through the map_ops)

Let me know what you think Song. I do understand the benefit of having a
__kptr instead, the refcounting is all there, and it would allow storing
rulesets in multiple map types. (and one less map type to maintain).

Mickaël, do you have any thoughts on this? I have v2 basically ready,
although it uses the BPF_MAP_TYPE_LANDLOCK_RULESET it changes a lot on
the Landlock side.

I appreciate the feedback from both of you.

Justin
