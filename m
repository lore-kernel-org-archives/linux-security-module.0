Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84F334370
	for <linux-security-module@vger.kernel.org>; Sat, 31 Jan 2026 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881281; cv=none; b=KspY1ngIpsFBiif+mE1n9nKswgM4vuy/rv3CtbuAWo8zHHEI3b887FC1mf9EYTOOXbB0X9pFaYUSj8MYaDftJyDghncQx1FhqBn7jcbZWX6Xwj4idIWneOUl9+jpqqW171XVZ4a/cdZ8acAUcWafio660uBBHKgWWLEgJbHJniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881281; c=relaxed/simple;
	bh=dpjaPwILjlU/oniaqSc2stmsi8w6oExuDRwCnyx5y6Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cn/xlcFol4NJkjgAXOmjqYcfgtt5ylShu/FBniDqiYqfK8VVNMH/baBLqQiXRY5vuDUoBfA0/Q6bKGV+UD4b2m4TR0YmjKKGWEd2autA62nTKCsXfZ3b9g7/embEOYVLLWyPqX3Q4/S1X+crRInhqogppNFSisX6dFIffwW+0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=jDAYd7cQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=akX3xwz8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="jDAYd7cQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="akX3xwz8"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 39076EC0075;
	Sat, 31 Jan 2026 12:41:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 31 Jan 2026 12:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769881278;
	 x=1769967678; bh=hQ7DSFG6XVVSZ+qseYfotWngJoLdhRJfEBTYhcw0d1A=; b=
	jDAYd7cQAQ+GxRzUPYQDcI4Lm+Z+Tjt6T4Xvn2A3tZb2ZZeIux4obCdC+Z7Tp/op
	v14knCYQnzMUp5jJl9dvc6EeqY6AVjHg4tKRvP/MU8Zgyl+wTvLVMoUK/thZGzKj
	CNP5NWx4OPe2h16fN35YpU/pgHyG8VTd30CyNKkzizol97Np63iC5+IcUWWJ2KF8
	KvSchf2knzoIn4g4ktoCvaInJdBlGsC0HqnnFfxEzaGDzbn7DeUSehjJJLixFC/N
	27LtEYC5kPUzmvdNUGMsqO5sDFcxjt+X3cavw77A3r+yZAG9n83rRaYhBXTgVSsO
	0crptnc//oeA4XkcnSOQdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769881278; x=
	1769967678; bh=hQ7DSFG6XVVSZ+qseYfotWngJoLdhRJfEBTYhcw0d1A=; b=a
	kX3xwz8Q+t3waCAziPMqizgmSbNJoKDfC5SfzbDaoSjOrKdUSaBhIYCuhZJ/9v/0
	otPVlvFXb22Ey3lN8CKLbW/ldvDEPoPeSYUQ8KuFd/af55F3MxXbzPw0DTa7k4s+
	M+hf8CCp8Qg7mRldyV2ZtJfXL5R6evKUvZAg3DiDDtIS58q+Z4BxX+8dLkZGudrZ
	OgIy68VOc87vWngQX/uYxC+PGvWACylPnD0dpD2v0FaVCqskC8EWFEI2xRbBR6z8
	hp9S7CS+r+iJsvFcZWzDU1dXnbwUYvk5CZO9yiLw2vFQlQzyYHc4FoCuTv1mvteJ
	SLd2MpFrkCxZeYn7EgnhQ==
X-ME-Sender: <xms:vT5-aSnr9TlXxKRsnNWby99bE0RIBbX4BfLKD7F3MqSVKUymTh4Xqw>
    <xme:vT5-acbWeymQWEOtK0bHt4OjHYo1lXzvi5xwOuP0APiCwdjL1lZ-LWfxNOGVw1601
    WWVEL7cxpphTkTryZhY4fDmun9HhY-JMROTcCbAOFqLha3Evg72wb47>
X-ME-Received: <xmr:vT5-aUQrVibsrTv1QlVAe5xxyLggpZ2_y6ImmiOYGPEfaiJ0AIeS964dykcR5_6dNzXvBqJOi133bXBuSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfe
    dtveegffdvtefhkeeiffefueelgeeugfduffehheejjeekgeegvdevvdffhfdvnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhg
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmih
    gtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghkfedttddtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepuggvmhhiohgsvghnohhurhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhi
    segrlhihshhsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehlih
    hnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vT5-aWs5zKUe5AlfJ2MddhdQL3IUZjxMUg6GgrQhJPbUp7o9bB1Ajw>
    <xmx:vT5-aWHErk3TWANxMb1vJqkNFcCOaYMVfaafSjYaAsCJdCyheL_SUg>
    <xmx:vT5-aXx55lAGru55D-w9jHyqyHHu80CBvYJMHPuFqjymzpV6R-NdJg>
    <xmx:vT5-aQ0entJ7fgTl3X4fzcDWSXBaK8vmi8jKYBx49ekDgY2T0SrVbQ>
    <xmx:vj5-aR9pL_pa-CzWPRdSZUCtpM9LtwgwUeePtfOo4ZrrBtSncYA4YYKw>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Jan 2026 12:41:16 -0500 (EST)
Message-ID: <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
Date: Sat, 31 Jan 2026 17:41:14 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Demi Marie Obenour <demiobenour@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>,
 Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
 <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
 <20260109.Ino1ahfef1iu@digikod.net>
Content-Language: en-US
In-Reply-To: <20260109.Ino1ahfef1iu@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/9/26 12:01, Mickaël Salaün wrote:
> On Wed, Dec 31, 2025 at 11:54:27AM -0500, Demi Marie Obenour wrote:
>> On 12/30/25 18:16, Günther Noack wrote:
>>> [...]
>>> On Tue, Dec 30, 2025 at 05:20:18PM +0000, Tingmao Wang wrote:
>>>> [...]
>>>
>>> What is unclear to me from the examples and the description is: Why is
>>> the boundary between allowed and denied connection targets drawn at
>>> the border of the Landlock domain (the "scope") and why don't we solve
>>> this with the file-system-based approach described in [1]?
>>>
>>> **Do we have existing use cases where a service is both offered and
>>> connected to all from within the same Landlock domain, and where the
>>> process enforcing the policy does not control the child process enough
>>> so that it would be possible to allow-list it with a
>>> LANDLOCK_ACCESS_FS_CONNECT_UNIX rule?**
> 
> Yes, with the sandboxer use case.  It's similar to a container that
> doesn't know all programs that could be run in it.  We should be able to
> create sandboxes that don't assume (nor restrict) internal IPCs (or any
> kind of direct process I/O).
> 
> Landlock should make it possible to scope any kind of IPC.  It's a
> mental model which is easy to understand and that should be enforced by
> default.  Of course, we need some ways to add exceptions to this
> deny-by-default policy, and that's why we also need the FS-based control
> mechanism.
> 
>>>
>>> If we do not have such a use case, it seems that the planned FS-based
>>> control mechanism from [1] would do the same job?  Long term, we might
>>> be better off if we only have only one control -- as we have discussed
>>> in [2], having two of these might mean that they interact in
>>> unconventional and possibly confusing ways.
>>
>> I agree with this.
> 
> Both approaches are complementary/orthogonal and make sense long term
> too.  This might be the first time we can restrict the same operations,
> but I'm pretty sure it will not be the last, and it's OK.  Handled FS
> access and scoped restrictions are two ways to describe a part of the
> security policy.  Having different ways makes the interface much simpler
> than a generic one that would have to take into account all potential
> future access controls.
> 
> One thing to keep in mind is that UAPI doesn't have to map 1:1 to the
> kernel implementation, but the UAPI is stable and future proof, whereas
> the kernel implementation can change a lot.
> 
> The ruleset's handled fields serve two purposes: define what should be
> denied by default, and define which type of rules are valid
> (compatibility).  The ruleset's scoped field serve similar purposes but
> it also implies implicit rules (i.e. communications with processes
> inside the sandbox are allowed).  Without the soped field, we would have
> to create dedicated handled field per type (i.e. scope's bit) and
> dedicated rule type for the related handled field, which would make the
> interface more generic but also more complex, for something which is not
> needed.
> 
> In a nutshell, in the case of the FS-based and scope-based unix socket
> control, we should see one kind of restrictions (e.g. connect to unix
> socket), which can accept two types of rules: (explicit) file path, or
> (implicit) peer's scope.  Access should be granted as long as a rule
> matches, whatever its type.
> 
> This rationale should be explained in a commit message.
> 
>>
>>> Apart from that, there are some other weaker hints that make me
>>> slightly critical of this patch set:
>>>
>>> * We discussed the idea that a FS-based path_beneath rule would act
>>>   implicitly also as an exception for
>>>   LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET, in [2] - one possible way to
>>>   interpret this is that the gravity of the system's logic pulls us
>>>   back towards a FS-based control, and we would have to swim less
>>>   against the stream if we integrated the Unix connect() control in
>>>   that way?

While I do think being able to control UNIX socket access via domain
scoping is useful (after all, it is an additional bit of information /
relationship that "normal" filesystem objects doesn't have, and
applications using Landlock might find it useful to control access based
on this extra information, either to simplify the policy, or because a
generic sandboxer can't come up with a pre-determined list of UNIX socket
fs rules, e.g. for applications which places socket in hard-coded "/tmp"),
I do share the worry about how this might get confusing from an API
perspective, as discussed in my GitHub comment [1].

Another way to put it is that, if FS-based and scope-based controls
interacts in the above proposed way, both mechanisms feel like "poking
holes" in the other.  But as Mickaël said, one can think of the two
mechanisms not as independent controls, but rather as two interfaces for
the same control.  The socket access control is "enabled" if either the
LANDLOCK_ACCESS_FS_RESOLVE_UNIX access is handled, or the scope bit
proposed in this patch is enabled.

With that said, I can think of some alternative ways that might make this
API look "better" (from a subjective point of view, feedback welcome),
however it does mean more delays, and specifically, these will depend on
LANDLOCK_ACCESS_FS_RESOLVE_UNIX:

One possibility is to simply always allow a Landlock domain to connect to
its own sockets (in the case where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is
handled, otherwise all sockets are allowed).  This might be reasonable, as
one can only connect to a socket it creates if it has the permission to
create it in the first place, which is already controlled by
LANDLOCK_ACCESS_FS_MAKE_SOCK, so we don't really lose any policy
flexibility here - if for some reason the sandboxer don't want to allow
access to any (pathname) sockets, even the sandboxed app's own ones, it
can just not allow LANDLOCK_ACCESS_FS_MAKE_SOCK anywhere.

Another possibility is to have this scope control as part of the
LANDLOCK_ACCESS_FS_RESOLVE_UNIX rule itself, rather than as a separate
scope bit, via introducing a "rule flag" (which is a new mechanism
proposed in [2]) which I will tentatively call
(LANDLOCK_ADD_RULE_)SAME_SCOPE_ONLY.  So for example:

- If the sandboxer wants to allow all socket access, don't handle
  LANDLOCK_ACCESS_FS_RESOLVE_UNIX at all, or handle it but have an allow
  rule at / with no flags.

- If it wants to allow access to only the sandboxed app's own sockets,
  handle LANDLOCK_ACCESS_FS_RESOLVE_UNIX, then place one allow rule on /
  with the rule flag SAME_SCOPE_ONLY.  This means that the allow rule
  "UNIX socket under /" only allows connecting to sockets in the same
  domain scope.  Additional rules without this rule flag can be placed on
  more specific places to add "exceptions" to allow access to more
  privileged sockets.

- To allow access to specific sockets only, not even the sandboxed app's
  own sockets, just use LANDLOCK_ACCESS_FS_RESOLVE_UNIX without this new
  rule flag.

This is slightly more flexible than just the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
scope bit plus LANDLOCK_ACCESS_FS_RESOLVE_UNIX, as it allows the sandboxer
to specify where an application can connect, even with sockets in its own
domain, and it also nicely avoids the "what feels like two independent
controls poking holes in each other" problem.  But it does mean more
complexity (although hopefully not too much), as we now need to introduce
the rule flags concept, but that is required for some other proposed stuff
anyway - quiet flags [3] and no_inherit [4] rules, and the rule flags
design is in a good state I think.

What do folks think?

(btw, when I say "sandboxed app" this can of course also mean multiple
applications in the same sandbox, e.g. like a container runtime as Mickaël
pointed out, which raises the probability that just having
LANDLOCK_ACCESS_FS_RESOLVE_UNIX would be insufficient, e.g. when bind
mounts are involved, or other cases which I haven't thought of right now)

[1]: https://github.com/landlock-lsm/linux/issues/36#issuecomment-3693123942
[2]: https://lore.kernel.org/all/f238931bc813fc50fc8e11a007a8ad2136024df3.1766330134.git.m@maowtm.org/
[3]: https://lore.kernel.org/all/cover.1766330134.git.m@maowtm.org/
[4]: https://lore.kernel.org/all/20251221194301.247484-1-utilityemal77@gmail.com/
