Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5D221F2F
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733104; cv=pass; b=KOwH0HAB6rMsPAiY5Nha/mRxOvbQUWZ6h5qIl8DKn88tI0txljpKZ5J+KcSrS2WZBgzuxgmNplmaEkxj1AdIVaS9WL2dnllWTIR+SH+2M5q3qRDDC6YpUFGqoQzAwqgd2H4AdCgUho7SNXncQbnRmNsjGktqMA2FFCzL5I2jlVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733104; c=relaxed/simple;
	bh=LHJgU5o4zlFKIDCYIg/sT/NOeaqAOnix6HRSAOXirFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gos5gEbvqfOfD5WvCRxl5mDFeSMmZsgbADIUkH20LfT6mtVR8xaz3aKWRcSewdTMKN757BVe/ES7O3h1fbGy3bOBoHZg4JxkbSWgU2CtnFDVlsLEWOOfgoqaHWvwNjgyWhzzt87xJ0YbP25pDph2AKEDSubYf0MttbNOgSlXv7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JkYmabei; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JkYmabei"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so2242630a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 17:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776733102; cv=none;
        d=google.com; s=arc-20240605;
        b=Xn6vw8jlUZ9bVZczvVGMXdd87Hvv3NzkTroo1nvb/wlfywqRjHcNGIvzj3m22dLEVe
         bSj2r2jLQm3pOeoX9PInvdnwbVVy+s+KNR9UC54X2dghtdVWmeaXnhZ8HXmOf2a6m3Ud
         MKGRTqJP+L8rrmOHBrE56S5D3VgCgjkiP1FDA6XTSqE0XM4su+ujlGb2kOG9JMu6fAYm
         LaeYx+vBdWF9aBJStxKvfIovctUHN231ZNcCm+cjSlSrdpf+EkOjRu0p1JxPu1tOtDNd
         e9UNT9bTvdNJ9HPicWOC93vW7XBXpc3mtxFYVMvZr/dcHsXdEBMxfm+V+S2yUGY44o1k
         upuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        fh=muUYG11nWF3Z1GrBPvsOe8eC4dmj5Q3IPqQDWlmLbaY=;
        b=TgD3xT3GJ0N6lu5z4eE2PgHMOL6G1RTcGt+A9Ew+lq1pfDuYHGhTlPRwo8YLwXLUBn
         UIX08d/ftlMR7A/t8G5wL3DIXSzYQ1oneEdv3Ke8aoAnQ41gTqcTS/zB4SrUox5MyXOs
         kvi0vQeh/Zlql2eh472jgHCqvyJLl6RA2UW0LjmO80gTVy/my0q2bfl5OAH+rxSJjvwQ
         3x2egkvPgXQ3br4FSj45+HPO8DMSzOCDOEO1nfXgqIEfFVPjUXjij0hyWWSs2OJ8wE7l
         o/TxmGdU+CLfQ9rYtuHEPn/tOKViLWuGKNYGhnVSr+lKBbj5myYTRDIfdfW3fxKTBLrN
         fNRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776733102; x=1777337902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        b=JkYmabeixhCW3tygHOkl8WHNX/J5tVEwBNxaOTCUx1fhT6a4VRqQ4KTAUyOp3RDzcn
         V8rNaSD14WyBq0UFkks5ao98rXVK3xZTp0vPPBgZXL+myN3j2A+m/YTxtYio3DbwnCqc
         VeQVeVooZ439Cgg6nHODQ1sgd8g/YMq2EUK6EcGw/jahwiVYFs7PCtBItL1d6bBvvr2I
         DVKePZQq+wXAxdNzkOrwyzwx5AM0ZK//yXwoI3hdFCf19AQFfnWSUAyB3TcdIc9mG3xf
         acFtYZZ7W9wyU5pL86gjdQm6SDB/HwvmuAyhoj9z3R9H9j7NVYzJKus5oAOsTWd+Mpyz
         hpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776733102; x=1777337902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        b=GI+HCDJz9IBHKzKVHlXD0+a32g8A5aEAzro2uDoRvuj/x5yaBQhl1RBsBh8UkdW0Oq
         U+Im3eZtoHfuNv57kRgQIvNtEXhWBM6fXKqA2FeT4LoCNWkO9bbUPi0AdpTutcwFbJ97
         JK7mAjzWwY05MgHif/pKUzpOGVHQoqLvXDsDR1BhnOhu9MwmKSbs9MhRvHbct8Eq3WHE
         c4xXACA1fIOrNYugyGZWrnCzicEEiOotEz5vMGoXNJo+fVndhNIDsBHwQBQKUWOu1oSD
         oWFXh+GUzmiPEBNfr4Zlv+QPt6Jgq2f18GDVMOQtHzb+GuaaZEWWWMJeChScIEaDXeH/
         OhhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5o358yC2eipi1eUeuvKJGrvWSO3pB5B9W+cfK7MF4UzK8UdgEHVaQWYhp9WkqOex4b0D8Xtm2WCnfYlZgKAy2hfivX/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fO9UKqT4M2OFE3ntdhGFd8KeCP2W++E+5YvNlsqx9RLQ0wZU
	rsD9ejDYuJs8X94VQGpru8yUO2znmNwYUsu6Kk6pw1tsinnmW7gIZBAi19EXA/l6v8pkM7Fiivf
	3xA4HGOlMFPghsF5ui5r6P7hybZOkmeRwERrb8ZLt
X-Gm-Gg: AeBDievDwhvFNNWkYXRGtYIvDIE2xyyxovG0ZG+ov/DwwBrbLt9JzZNUjh9ldB3t5VN
	QCO8peiyfKTuLBGHvHM1yO/27+lsmUneNwFj7kOBWA83BIzmSc/bgwd016YwrLhFqw5jCVc7tpC
	6gBEAfuNRUH1G4HFlhAIXkrM2jPhPDm/1GvjIIz9+ZNliLyDlA0+j2f5CgocLsZFk8BZHNHo1qW
	772zFFr5SfI80MzN8vFnPYmIiDNKF3u/U9ojic5sB3xiHPk/XIQxCdapc5Jie8gjZh8Xo5U2+rT
	K9LkBl318F0NMcMo4irDrYeejm0q
X-Received: by 2002:a17:90b:4c8c:b0:35f:be09:1a2b with SMTP id
 98e67ed59e1d1-361404104d3mr15707115a91.10.1776733101940; Mon, 20 Apr 2026
 17:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca> <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
In-Reply-To: <20260417191749.GK2577880@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Apr 2026 20:58:09 -0400
X-Gm-Features: AQROBzD3bPay_GfERLBaTKyLHFewS9zTfkn7kJbzuJjwn1OBJ7EB6NLWqF-EJvc
Message-ID: <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 3:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> On Wed, Apr 15, 2026 at 05:40:04PM -0400, Paul Moore wrote:
> > > The NIC doesn't know anything more than the kernel to call the LSM
> > > hook. It can't magically generate the label the admin wants to use an=
y
> > > better than the kernel can.
> >
> > The NIC presumably knows how to parse the firmware request and extract
> > whatever security relevant info is needed to pass to the kernel so the
> > driver can make an access control request.
>
> Not in practice, we'd have to agree on how to describe the "security rele=
vant
> info" and that won't happen..

I think you're going to find that you need to describe the security
relevant info regardless of how you implement things, but we can leave
that discussion for below.

> > Leon mentioned that different firmware revisions would have different
> > parameters for a given opcode, and that one would need to inspect
> > those parameters to properly filter the command.  Is that not true, or
> > am I misreading or misunderstanding Leon's comments?
>
> They are ABI stable, so there will be rules about future changes that
> old software can follow to ignore or reject future things it doesn't
> understand.

Good, "ABI stable" means there is some hope :)  Based on the various
discussions I'm guessing both the ABI and any assigned numbers
are/will-be vendor specific?

> > > > The access control point itself represents the requested
> > > > operation.  This is possible because the number of networking
> > > > operations on a given packet is well defined and fairly limited; at=
 a
> > > > high level the packet is either being sent from the node, received =
by
> > > > the node, or is passing through the node.
> > >
> > > I think we have the same split, fwctl send/recive analog is also very
> > > limited.
> >
> > Sure, but I thought the goal was to enforce access controls on the
> > firmware requests based on the opcodes/parameters contained within the
> > firmware request blob/mailbox?
>
> Yes, that's the goal. It is the same as iptables being able to
> identify that a send system call has a packet that is http or dns.

I think we still have a disconnect here.  A packet being a DNS or HTTP
packet is different from an opcode.  The opcode in the iptables isn't
"DNS" or "HTTP" it is "INPUT", "OUTPUT", or "FORWARD".

Most LSMs will want to know who is initiating the firmware request
(the subject), the requested operation/opcode (the action/verb), and
the target of the request (the object, which in this case is likely
the kernel or the device).

For most LSMs, I expect the subject to be the process making the fwctl call=
.

Similarly, the object will likely be either the kernel or the device itself=
.

As I understand things, the action/verb is going to be the opcode
within the firmware request.  If you believe I'm wrong about this
please help me understand why.

> > > LSM takes the secmark and determines if the access control point
> > > accept/rejects.
> >
> > At this point I think it would be helpful to write out the
> > subject-access-object triple for an example operation and explain how
> > an LSM could obtain each component of the access request.
>
> I think I am talking about this:
>
> app_1 FWCTL_RPC op_unpriv_t
> app_2 FWCTL_RPC op_priv_t
>
> - app_x broadly comes from the process executing the ioctl

Yep.  Were on the same page here.

> - FWCTL_RPC identifies the IOCTL userspace called to send the RPC
>   packet

Maybe.  That is an option.

> - op_X_t is the result of the classifier inspecting the RPC
>   packet. Admin tells the classifier to return op_X_t similar to
>   how --selctx does for iptables.

I've tried to explain how this doesn't match with secmark, but I'm
evidently doing a poor job.  If you want to continue with the secmark
comparisons it might be helpful to spend some time configuring secmark
on a SELinux system, and writing policy for it, to see how it works.

Beyond that, I think you will find that most LSMs - although not all -
define their security policy via an abstract subject-action-object.
The policy either allows or rejects a subject's ability to perform a
certain action on an object.  My concern with your example is that the
object isn't what is actually being acted upon, it's the requested
action.  The fwctl ioctl/API allows a user to act on a device, with
the actual action being specified by the fwctl payload.  From what I
can see, the classifier's output is the action, not the object.

> > > Same as for networking. Admin understands, admin defines, kernel is
> > > just a programmable classifier.
> >
> > Are you able to define all of the firmware request operations at this
> > point in time?  That is my largest concern at this point, and perhaps
> > the answer is a simple "yes", but I haven't seen it yet.
>
> We can identify all the IOCTL points where the RPC packet will be
> delivered to the kernel (send/recv/etc)
>
> We cannot pre-identify all the mlx_XXX_op_t's an admin might want to
> use.
>
> The same way secmark cannot pre-identify all the XXX_packet_t's.

Once again, I think there is a disconnect or misunderstanding, on a
SELinux system using secmark all of the packet types, e.g.
"XXX_packet_t's", *are* pre-defined in the SELinux policy.

--=20
paul-moore.com
