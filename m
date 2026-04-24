Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94033DC4D6
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041368; cv=none; b=SoZM0N/iMASIonguVzZ4o2qjVNZUiu5d9ChAcOQZjN0i8YaaI/yuGCleFj7yIV4NyoF3TlaW1z9PN31o9rBnoF8JU8jIUu8YJ1gzGjb7sfbkYOU+BubHksP+V6Og7jfmaQ4l1w/MVnwFpOMko8BbextAXn/+UqiQtlVwe1whVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041368; c=relaxed/simple;
	bh=Re59DPAnmFnNzJbvxM1fdICxhhUUbMUQeMYokWbznfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7BYythAf3/S6hgqGM2aktdUeTsatjvjEZ0Knv4S+gitcQFqpOkBLYk9UVtDBIbrtGjp5Iz5pBe9+mS9cKBSBZdsqYfAirEDejoPg5b8Ofqt7c+k84NO7tZLfXUBcSkc9u6pWX0rwBXPVsqjv2hb6pkeH4/nyyZnbVplEyNzAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GkVxPYqJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GkVxPYqJ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acae26e564so90518646d6.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777041366; x=1777646166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqpHsu9O8KQfZPJUE6YxK9zkVCDI7j2Hht6awCscAf8=;
        b=GkVxPYqJJZrDQrQTwHmS1QvV6RRqUgu7h198QFhcR6eyvXs2rcY3NR0Eng9PvZvEE/
         DUlJnvJIQhReHJiPzLpSy0ak5OCqNfom/AFOHG6QWcATt0TXAruWbwzqCR9gDQt8FmTr
         GLruX4eYXsTEvIADxRqd3s109vADjWwKkfhTs0Q57O2l48ZHgGP9jnc2UyT1bm+/n3qT
         vZo4WGwWee2ZEMvN4GOhnOFmtW/R6rQIR55Hqo4ZKXvq/pRxzNSTOFSk6VkorNxyH/8n
         wzPHpYTHs2ME6PuAYA0uCYiotrDb2w2tbCwtvICrBqYcuPeNNSp/EIR8J/1xtL+Gg9t0
         gFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041366; x=1777646166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqpHsu9O8KQfZPJUE6YxK9zkVCDI7j2Hht6awCscAf8=;
        b=NVTLpAtL9LJrQ5V0moPkGwaDhfhBY+/XZtIImUXqGr4sUSF1AUQg0TpuH8ImLLdpLF
         B6//InbFHA28ax/QRXXwSN+tm2NmIG3xPD0a4/iLri8r4Rgx++TLEP43fGHCLrhzW3W+
         Mkt1fTI+V7lssAEGJdmdlPDUiG/X2QVQnz1SfjngYahV4Ci3ke4142VNZNBQl7haIVRz
         Axev4uAkqNKmiG2/ZFQ+WStHMdQQoXkc/OIiu9Vt4cKnONkurrEsu8IBZ5uq/B3UdcDc
         +HkZ8jW6CVpwunf6TNhJXLp+fuJxggn7ouTGqYFq5KcwccDSUJ2b0kii7dueT6qIdyNP
         gPzg==
X-Forwarded-Encrypted: i=1; AFNElJ8S/ARUAUfPgSshPPTJHojTff53O7TJ/hSNlEgnqEyWnUMn0wjwbAXqI/UuzMpCxUULy4tpeCeSD+EpZNBd76G2Z+oppL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1DMtcFlgDUsQWkUovO41b4u8FJMpsUQkGxkQ5js3dp45b88N
	WdZDW6aDD6JgIZbTTZywiCmWwoBvAwaN6iGXMIXO8d/RhG7Z5lkqEGf336++xtU/UJw=
X-Gm-Gg: AeBDiesSK2Ee6l9uo+pZ7Oc9SOeMlgFcGQHKNgDE1/Uxw878+P47MPVMaFTF0u+Vi3i
	2GBXLSTM6Wb4mGSFDQpkOrtrKZnUuuuX832ttoxp2TXxZ6/FG64wda8Q5pi3TO2d8qGXlHw8IfW
	mM1Obq2wOTsG0pVbFsjxKZ0vU9wBJj+g3FEBqo2aYa7w2k2dwnIWMvy9oc4FrfR7CSMHzcEOHs5
	+IKkaUROSRu3MsED/dqCmH2jTBQVXgyj8bqxQeur6Z5FMGqm26r7z19ez1AZRZJt2jNt8fm9GAa
	hiSVCEd6PuCnLvh3ziaxCPyQk1sbBjL6vOANuiuJwRWnQv8gOoBSdXv4/9dgbsPXGIWfpBbA2xx
	KBJ/9YXfrOP/LVF/yPPpbl4Uxx+bl6KsdnQdrY1RzKXwr8ERgFupY74jt6iVD66hsT50wjZwPml
	E709stidDGzHXmvUd2EuOS1i/Efzg9UmzKLqPn0SfhMrZ55Pc43HScC4A8dj3VCilQ5JzVgPwIj
	m/+xsJ3/3pPp3FxdILCtpHdekg=
X-Received: by 2002:a05:6214:5d82:b0:89f:9bc2:20d1 with SMTP id 6a1803df08f44-8b0280c8cf0mr475388426d6.7.1777041365807;
        Fri, 24 Apr 2026 07:36:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b031f65a27sm180664046d6.16.2026.04.24.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:36:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGHdT-00000002nbb-2MlG;
	Fri, 24 Apr 2026 11:36:03 -0300
Date: Fri, 24 Apr 2026 11:36:03 -0300
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
Message-ID: <20260424143603.GB3611611@ziepe.ca>
References: <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>

On Mon, Apr 20, 2026 at 08:58:09PM -0400, Paul Moore wrote:
> > > > > The access control point itself represents the requested
> > > > > operation.  This is possible because the number of networking
> > > > > operations on a given packet is well defined and fairly limited; at a
> > > > > high level the packet is either being sent from the node, received by
> > > > > the node, or is passing through the node.
> > > >
> > > > I think we have the same split, fwctl send/recive analog is also very
> > > > limited.
> > >
> > > Sure, but I thought the goal was to enforce access controls on the
> > > firmware requests based on the opcodes/parameters contained within the
> > > firmware request blob/mailbox?
> >
> > Yes, that's the goal. It is the same as iptables being able to
> > identify that a send system call has a packet that is http or dns.
> 
> I think we still have a disconnect here.  A packet being a DNS or HTTP
> packet is different from an opcode.  The opcode in the iptables isn't
> "DNS" or "HTTP" it is "INPUT", "OUTPUT", or "FORWARD".

I understand that

> Most LSMs will want to know who is initiating the firmware request
> (the subject), the requested operation/opcode (the action/verb), and
> the target of the request (the object, which in this case is likely
> the kernel or the device).

How is
  system_u:object_r:httpd_packet_t:s0

A kernel or device? It is a label for packet contents. I also want a
label for packet contents.

> As I understand things, the action/verb is going to be the opcode
> within the firmware request.  If you believe I'm wrong about this
> please help me understand why.

You could make that choice, I'm arguing we should not, and it should
be in the object side.

> > - op_X_t is the result of the classifier inspecting the RPC
> >   packet. Admin tells the classifier to return op_X_t similar to
> >   how --selctx does for iptables.
> 
> I've tried to explain how this doesn't match with secmark, but I'm
> evidently doing a poor job.  

Yeah, I don't get it at all, sorry. I fell you are making some very
nuanced distinction with HTTP being an object but the HTTP-equivilant
in fwctl is not an object, I can't follow it at all.

By that logic:

   iptables -p 80 --string "GET"

Is an action, and it should get a unique action in the tuple.

> If you want to continue with the secmark comparisons it might be
> helpful to spend some time configuring secmark on a SELinux system,
> and writing policy for it, to see how it works.

I think I have a pretty good idea, you haven't said anything that
contradicts what I expect..

> certain action on an object.  My concern with your example is that the
> object isn't what is actually being acted upon, it's the requested
> action.

Object is a label for the packet contents.

> The fwctl ioctl/API allows a user to act on a device, with the
> actual action being specified by the fwctl payload.  From what I can
> see, the classifier's output is the action, not the object.

You can take that view, it is certainly one valid way to look at it.

But it is completely impractical.

I am arguing for the secmark like view where the content of the packet
decides the object label.

> > The same way secmark cannot pre-identify all the XXX_packet_t's.
> 
> Once again, I think there is a disconnect or misunderstanding, on a
> SELinux system using secmark all of the packet types, e.g.
> "XXX_packet_t's", *are* pre-defined in the SELinux policy.

"Pre-defined" in a text files in user space controlled by the admin.

Admin can "pre-define" their fwctl ones too, what is the issue?

AFAICT the only debate here is you want to make fwctl's packet content
an action while allowing iptable's packet content to be an object.

Jason
