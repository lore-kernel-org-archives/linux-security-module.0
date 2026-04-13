Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CF325726
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122364; cv=none; b=EQxJCq2XVkQWlwGuCHFZyYLGRnAwYioqRHbD3WpbXN/fX15xWxS1KAJZUL/jZ8mb9ojMGvDyXh1tbFVJwgvaRxhQoH0LgUNtpDPRXJCsq0RoJu35ebO60gdtRnqxtH4jFdu8EdlpWS3iOtPDi5S+tw6tKudt4eSx/O4iGdZmIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122364; c=relaxed/simple;
	bh=Lwd5+U+8gXFkcaDQSx+GXWF9g5z2SGRxQlDu4DBaHGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMUkn76sqoO4hNOmhI9iNXuKrUbsHO0TKhxREvpE5SaAKVx3gL1q4pQrE7tzJCIMLEaASI+622BtXd/76LQtfpM96ulzwRsWodR22QsMWOXubp5+bVupmpkZEsz0q+UeXl997WsGgMz/rlIBKN2xRiG3w54ecQDh35whR2heVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S762ETML; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S762ETML"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d59d249fbso52358201cf.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776122362; x=1776727162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FQkfHlRKdQNLxeoIhr6739G0yAYwiCkG/RlpNK55h4g=;
        b=S762ETMLMmpoc0XbcLZOe7rAzHqBVfjLoYzbqXfCi3FUHkcA7omBLazrecLPfYIxn4
         LFT9WUi/PmuLqcYduIYfpp16MJZ92Wesmlu47V2+yJbQ4nVlWdydS5leYi7FiMFxln+n
         elGFKQY4Vp5xXrBNujVLvyFC1Vc3++sbrEJAKxNyA3DRjEz1rn1G76P8she/V1CU9DoS
         ntCuxtPOqyiugIk6k9WZ8yIvASCZKgRjCWiQyv0bVgkwxaqUrdR0E5yKMwmTQHQGNw5O
         CVkFRfWZ9ncfwkhlS3H3TQ7y5GZ0EUVeXExF7NH7YtMDVB724/IguKSIW2mGiK+84hiV
         T++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776122362; x=1776727162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQkfHlRKdQNLxeoIhr6739G0yAYwiCkG/RlpNK55h4g=;
        b=SJusCoppJCqJ11FWWO4HFF1kBCJOkIpRFwKMD8kdgNOtGJ4skU4u8LmGjPBCxZJLIy
         r3+yubWPwDEUCr1I1TMH3q1MP9SG8M6HmsUqpF9hEw0r4+npkqGfxKnfhiymx3rKdnh6
         ARCzqmxHU0VPhPwAjZKvU+/+6jj0P/CBXIZMyKZdwP0vS05cfvXsKDvhsO798RvuCtfg
         8HKBmdn9pn3U7LF0iHtfLSxDiM2E+eW6a3fyrcRHzwSPkhYHI9Jy48+7DvpXqDkcKU6M
         puTer4XZQzw24KM+hTpohyp16TYx1ob3YX7GN+ndrsswteic1I4yGShZ19EcTLdzJ+76
         30Fg==
X-Forwarded-Encrypted: i=1; AFNElJ8WCcD6OySe4Baldthiu7Y/35TL6wB8o8tLRfJso3C8QVVB7tsg0s9LvaF1E4vG7FW5tJYX3X+DUaSVxfHmTTYtlf+5BmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUBgymmnMCkcpfGzp200CcX1Sj1uHoum4Ht3N8vuj1uSLsrn5
	6D4/PSyeUcx/nuo8WGVJHhQnwa0RfZYLVABg9EFF/wUXnL9yOhekvfNp3YcIJPPzmuY=
X-Gm-Gg: AeBDietQuBFfcssdHoj3jt/1Yoai/vuNH9bLgKiDwi1rkF6CK+PX8xpqincFu2sWMIA
	thHYAjDuZccrcFB3nkK67Vc67rDBxPVxL5epUILwGsjVt05K9s8VQS1zfTJfTxJZRtmXzKszgv7
	CecBQ+xQ9DItMH2UvoR5W85tGv2t5F4MO9QqOqN14oxrxd039IJgb1I/ycg5Lhr9zh4O9aYV1M4
	fK40bEbSPlC6kbN4tcxS5acC/KheqQmdBngaJQ0L3XT0wvjer5VvbrjMSjL6LV8MpJdkX0AMRjv
	dXtoRYb3ccCfNrGiFl7+GnemuRaVUYRm7/c7FueDCIPH08NBRUlj17UN+vFH0YOev1Ka0hBmV66
	8AYALRu86fuWv3wDI+D+mgASypPNvH/rYQO0OsfTH9WzrD0pfGkvNctLHTWTsD3/8KGcpG4VVGq
	LZeVvUAl8L6PSXnm6jDlqWBrX0nJatMdl5lPzEPeEPWEqLEdWETyTF6Mc0ySKXW73/Kvj6GzMXg
	OIsbw==
X-Received: by 2002:a05:622a:3c8:b0:50b:30d5:c6fb with SMTP id d75a77b69052e-50dd5c0ef5cmr239237521cf.63.1776122362169;
        Mon, 13 Apr 2026 16:19:22 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50de6bc04e0sm68655491cf.19.2026.04.13.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:19:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCQYq-00000007IUJ-1zsW;
	Mon, 13 Apr 2026 20:19:20 -0300
Date: Mon, 13 Apr 2026 20:19:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paul Moore <paul@paul-moore.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260413231920.GS3694781@ziepe.ca>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal>
 <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal>
 <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>

On Mon, Apr 13, 2026 at 06:36:06PM -0400, Paul Moore wrote:
> On Mon, Apr 13, 2026 at 12:42 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
> > > > We are not limited to LSM solution, the goal is to intercept commands
> > > > which are submitted to the FW and "security" bucket sounded right to us.
> > >
> > > Yes, it does sound "security relevant", but without a well defined
> > > interface/format it is going to be difficult to write a generic LSM to
> > > have any level of granularity beyond a basic "load firmware"
> > > permission.
> >
> > I think to step back a bit, what this is trying to achieve is very
> > similar to the iptables fwmark/secmark scheme.
> 
> Points for thinking outside the box a bit, but from what I've seen
> thus far, it differs from secmark in a few important areas.  The
> secmark concept relies on the admin to configure the network stack to
> apply secmark labels to network traffic as it flows through the
> system, the LSM then applies security policy to these packets based on
> their label.  The firmware LSM hooks, at least as I currently
> understand them, rely on the LSM hook callback to parse the firmware
> op/request and apply a security policy to the request.

That was what was proposed because the idea was to combine the
parse/clasification/decision steps into one eBPF program, but I think
it can be split up too.

> We've already talked about the first issue, parsing the request, and
> my suggestion was to make the LSM hook call from within the firmware
> (the firmware must have some way to call into the kernel/driver code,
> no?)

No, that's not workable on so many levels. It is sort of anaologous to
asking the NIC to call the LSM to apply the secmark while sending the
packet.

The proper flow has the kernel evaluate the packet/command *before* it
delivers it to HW, not after.

> so that only the firmware would need to parse the request.  If we
> wanted to adopt a secmark-esque approach, one could develop a second
> parsing mechanism that would be responsible for assigning a LSM label
> to the request, and then pass the firmware request to the LSM, but I
> do worry a bit about the added complexity associated with keeping the
> parser sync'd with the driver/fw.

In practice it would be like iptables, the parser would be entirely
programmed by userspace and there is nothing to keep in sync.

> However, even if we solve the parsing problem, I worry we have
> another, closely related issue, of having to categorize all of the
> past, present, and future firmware requests into a set of LSM specific
> actions.  

Why? secmark doesn't have this issue? The classifer would return the
same kind of information as secmark, some user provided label that is
delivered to the LSM policy side.

When I talk about a classifier I mean a user programmable classifer
like iptables. secmark obviously doesn't raise future looking
questions (like what if there is httpv3?) nor should this.

> The past and present requests are just a matter of code,
> that isn't too worrying, but what do we do about unknown future
> requests?  Beyond simply encoding the request into a operation
> token/enum/int, what additional information beyond the action type
> would a LSM need to know to apply a security policy?  Would it be
> reasonable to blindly allow or reject unknown requests?  If so, what
> would break?

I am proposing something like SECMARK.

Eg from Google:

iptables -t mangle -A INPUT -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:httpd_packet_t:s0

Which is 'match a packet to see that byte offset XX is 0080 and if so
tag it with the thing this string describes'

So I'm imagining the same kind of flexability. User provides the
matching and whatever those strings are. The classifer step is fully
flexible. No worry about future stuff.

I'm guessing when Casey talks about struct lsm_prop it is related to
the system_u string?

> > ... Once classified we want this to work with more than SELinux
> > only, we have a particular interest in the eBPF LSM.
> 
> One of the design requirements for the LSM framework is that it
> provides an abstraction layer between the kernel and the underlying
> security mechanisms implemented by the various LSMs.  Some operations
> will always fall outside the scope of individual LSMs due to their
> nature, but as a general rule we try to ensure that LSM hooks are
> useful across multiple LSMs.

I don't know much about SECMARK but Google is telling me it doesn't
work with anything but SELinux LSM? We'd just like to avoid this
pitful and I guess that is why Casey brings up lsm_prop?

> > Following the fwmark example, if there was some programmable in-kernel
> > function to convert the cmd into a SELinux label would we be able to
> > enable SELinux following the SECMARK design?
> 
> As Casey already mentioned, any sort of classifier would need to be
> able to support multiple LSMs.  The only example that comes to mind at
> the moment is the NetLabel mechanism which translates between
> on-the-wire CIPSO and CALIPSO labels and multiple LSMs (Smack and
> SELinux currently).

Ok, I think they can look into that, it is a good lead

> > Would there be an objection if that in-kernel function was using a
> > system-wide eBPF uploaded with some fwctl uAPI?
> 
> We'd obviously need to see patches, but there is precedent in
> separating labeling from enforcement.  We've discussed SecMark and
> NetLabel in the networking space, but technically, the VFS/filesystem
> xattr implementations could also be considered as a labeling mechanism
> outside of the LSM.

Makes sense

> > Finally, would there be an objection to enabling the same function in
> > eBPF by feeding it the entire command and have it classify and make a
> > security decision in a single eBPF program?
> 
> Keeping in mind that from an LSM perspective we need to support
> multiple implementations, both in terms of language mechanics (eBPF,
> Rust, C) and security philosophies (Smack, SELinux, AppArmor, etc.),
> so it would be very unlikely that we would want a specific shortcut or
> mechanism that would only work for one language or philosophy.

Okay, it is good to understand the sensitivities

> > Is there some other way to enable eBPF?
> 
> If one develops a workable LSM hook then I see no reason why one
> couldn't write a BPF LSM to use that hook; that's what we do today.

I was thinking that too

> However, it seems like direct reuse of secmark isn't what is needed,
> or even wanted, you were just using that as an example of separating
> labeling from enforcement, yes?

Yes, and looking for a coding example to guide implementing it, and to
recast this discussion to something more concrete. It is very helpful
to think of this a lot like deep packet inspection and
classification.

That the packets are delivered to FW and execute commands is not
actually that important. IP packets are also delivered to remote CPUs
and execute commands there too <shrug>

At the end of the day the task is the same - deep packet inspection,
classification. labeling, policy decision, enforcement.

Thanks,
Jason
