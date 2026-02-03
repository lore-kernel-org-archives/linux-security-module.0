Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9E1799F
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081998; cv=none; b=chtjpSEkWA65IcTDzSVeVYI63Rhj0ZRxqmrBlMFq8xKyFBPoDtZPlsyYaRB/E0FC++G2exY2rp5ooSTafWxWPUei3W7FMuQ64b2QKyKNploAzE5j3ogxYMiMdO5LII/HS63ExZ9AzeVpuY+9J0VLOYwuOh82WfM21i0HNAiqjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081998; c=relaxed/simple;
	bh=dP/iP5dcXBJcTBe5qkLFNLdLK68NOhA1nTd8lrZhhIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsEEjdQy7ZaMF0y/AMNSbJIJ1SUGoT2Z+vv1xQnxYXKBetXA5eEwQPnM9pRUJAeIz9aim/39gnHoRaBopuQyUed6ej+sM3OtcFb84MmIhv/3oJjb62RDmzcPi49FiWS6Ju/WRdc9sY+ekE5flUUYqdGp2rBpCsBZ/uoOQEHjM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=B6Xfc7JY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlW8su53; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="B6Xfc7JY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlW8su53"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 19CEA1D0007E;
	Mon,  2 Feb 2026 20:26:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 02 Feb 2026 20:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770081994;
	 x=1770168394; bh=KUTS+gTwqc61IPWkhluozosuypH0weUxu4HyHILDWRQ=; b=
	B6Xfc7JY59Gi8frDalE4J5wCkRSmaB270b5m2IDQXYcjHEFS3h5HG0xx4slMtUm3
	3tOVzfVGf/euxV1yxclMxsScba+6mVC6rDa09/us4sh/wf2l2XNmgzwwgRb4YjfJ
	e/IwttAXZkig0+8NLslK2g0/7Fus1m3TohvLsOfkOZCc+BvPJma6C5Cv0vrnleIl
	xC1lkZA1SrNqnTTYqDav0mYl5TrCvE4LsY2M+QIWcavMDkFAfjwOJljLfUalVPm1
	8rqqjL1mGQyYdaSCZTKKqbpEqCuazAJlqXizMzAzcafQtTccUmh4w3A+To6YJt5V
	vJv08CVzAtMdwub39DtMEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770081994; x=
	1770168394; bh=KUTS+gTwqc61IPWkhluozosuypH0weUxu4HyHILDWRQ=; b=Q
	lW8su53+dxC3kWiwIhgt01cFKb/voAAItOtXJbBK/1D6hI5tmx0JI6mTJX/Qoxuf
	6GeAOgRyopY0Xe2gNtN/WTc49Ukx6w3vLuKRnWWN/Kkws733jnqWzxMr5fD4t8t7
	PjXFP9nGXhMN9I8OSCLfR+oxgpeHTWtIliN/4eGco6ipzybrU6mZ3D5PymkrPh1u
	4yj18P6F5rIfybbRJkewEKH8oIHdM8ySkvtK1PIxsqGN4FYZMHj+XexlD74mctzu
	d0sV5sEi6jeG02BGLZRosP0cCKJSqWj7AY8exG5rxuCrPIDPrH2OKeQGrS9TLBcq
	/tvn9X+nCyYcZZ0wvjKpA==
X-ME-Sender: <xms:yk6BaYEr_OTi8N8otiv7W0l77UxQCnoodeR0iI2x0E1J-RHUw5GAsg>
    <xme:yk6BaT5MFDq4qbxzWkkswmxE7eRK9jYyViCq0TiG5diEBAHlvXygAS_ZyAibERQiX
    SxcMv4oXx3_Kwk2teBZDDo0pIBokqwG4RD5-aQd7u3-7R1sXFgb9sU>
X-ME-Received: <xmr:yk6BaVz_aYvqlaBk7sKkTMSCi4OZBJXPuG3ulXlY6NdOD439UB1lZ3KL12n2dXPMDYYwt0w3Yu5Q1mbC1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehuthhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    hitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkheftddttdesghhm
    rghilhdrtghomhdprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehh
    ihesrghlhihsshgrrdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:yk6BaaMX69UVPY_gC_F8OE8KKKuJnCJra_N1UXyIsp4azWu7OeaRvw>
    <xmx:yk6BaTmyGfIZ44wkC5TcbnrZ_i04WbvVKpIRMsCoXvP93xQD4X-2sw>
    <xmx:yk6BaXTOPffJ6_DfU2jXxoJz6iVQT1w_YMhvdvE8y-8dQPUrR_Vogg>
    <xmx:yk6BaaUbxIAU2ME839LIjJhsSq3N3vtBjpOByRBHkxTetA66Y-6OnQ>
    <xmx:yk6BafzJpSGBqZqRJxybKvqD_BJ08QJ5kxlq6dWdKH5nOPTDluBANVR5>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 20:26:33 -0500 (EST)
Message-ID: <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
Date: Tue, 3 Feb 2026 01:26:31 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: Justin Suess <utilityemal77@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn
 <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>,
 linux-security-module@vger.kernel.org
References: <cover.1767115163.git.m@maowtm.org>
 <20251230.bcae69888454@gnoack.org>
 <dc9b99b6-14a1-45b6-a23f-0b24143dac58@gmail.com>
 <20260109.Ino1ahfef1iu@digikod.net>
 <f07fe41a-96c5-4d3a-9966-35b30b3a71f1@maowtm.org>
 <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël,

Thanks for the feedback and explanations :)

On 2/2/26 20:32, Mickaël Salaün wrote:
> On Sat, Jan 31, 2026 at 05:41:14PM +0000, Tingmao Wang wrote:
>> [...]
>> What do folks think?
>
> I'd like to keep a clean API, with a "scoped" field handling IPC
> scoping, and an "handled_access_fs" field handling filesystem-related
> accesses.
>
> One thing to keep in mind is that we could add a new kind of "handled"
> field that would enable to add rules identifying e.g. processes,
> cgroups, or Landlock domains, and that could be used to add exceptions
> to the current scopes.  This means that we need to have a generic way to
> handle this case.
>
> What is the issue with two complementary interfaces (scope and access)
> used to express a policy about connecting to UNIX sockets?  We just need
> to make sure that scopes and handled_access_fs dealing with UNIX sockets
> are like binary OR: if the scope is set, then the domain can communicate
> with peers which are in the same domain, and if the handled_access_fs
> right is set, then the domain can only communicate with matching sockets
> (OR scoped ones if the scope is set).

Right, I see what you're saying, especially with the "additional access
rules for other scopes" example, and I think I'm happy with this.  I guess
my attempt at trying to make the API more "elegant" would introduce
complexity and also create future inconsistency if other existing scope
bits are combined with handled_access rules.

> [...]
> Anyway, we need to decide if this should be merged in Linux 7.0 (next
> week) or not.  I'd prefer to merge it now because I think it works well
> and it's not a new concept wrt the abstract UNIX socket scoping.
> However, if there are any concern, I'd like to hear them now and I can
> delay this merge if needed.  This patch series still need a new version
> but that should only be about cosmetic fixes.  WDYT?

I ended up being pretty busy today but I can definitely send the next
version tomorrow with your formatting changes and comments.  I'm happy
with it going into the next merge window if you are.  Justin raises a
point about having these two mechanisms in the same ABI version - see
below for consideration.

>> [...]
>
> My main concern is about user space libraries and users that may want to
> have conditional enforcement for compatibility reasons e.g., only
> enforce LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET (let's say ABI v8) if it can
> also set LANDLOCK_ACCESS_FS_RESOLVE_UNIX (let's say ABI v9).  I see two
> ways to deal with this case (if needed):
> - add synthetic access right to easily let users "combine" two access
>   rigths or none;
> - have a more generic way to AND and OR access rights.  I'm thinking
>   about updating the Rust library in this direction.

I'm not sure I fully understand the complexity here, but I think, assuming
these land in separate kernel versions, it will have to be that if both
the scope bit and LANDLOCK_ACCESS_FS_RESOLVE_UNIX is requested (maybe if
the user actually adds rules containing RESOLVE_UNIX access), but only the
scope bit is supported, then it will have to skip enforcing pathname UNIX
socket restrictions altogether by skipping both the scope bit and the
RESOLVE_UNIX access (if in best effort mode), or fail (if in hard
requirement mode).

I don't immediately see how further customization ability (e.g. synthetic
access rights or other AND/OR combination) could be used - if an app needs
access to a privileged socket and can't pre-open it before
landlock_restrict_self(), then the only realistic choice is to not use the
scope bits if LANDLOCK_ACCESS_FS_RESOLVE_UNIX is not supported.

On 2/2/26 22:03, Justin Suess wrote:
> Regardless if you merge the patch series now in 7.0 or a later version, I think there is something to be said
> about having the filesystem and scoped unix access right merged in the same ABI version / merge window.
> 
> As you pointed out earlier, the combination of the two flags is much flexible and useful to userspace
> consumers than one or the other, and if the features were merged separately, there would be an
> awkward middle ABI where user space consumers may have to make compromises or changes to
> sandbox between different versions or change application behavior.
> [...]

Given that the scope bit and RESOLVE_UNIX access right are in some sense
part of the same system (they interact in an OR manner, after all), there
is some positive for having them introduced in the same version, but on
the other hand, with my above reasoning, I don't think these two
mechanisms (scope bit and RESOLVE_UNIX access) being in different ABI
versions would be too much of a problem.  In either case, for applications
which require access to more "privileged" sockets, when running on a
kernel without the RESOLVE_UNIX access right support, no pathname socket
restrictions can be applied (i.e. it won't use the scope bit either, there
isn't much "compromise" it can make here).  On the other hand, if
RESOLVE_UNIX is supported, then it knows that the scope bit is also
supported, and can just use it.

Furthermore, an application / Landlock config etc can always opt to not
use the scope bit at all, if it "knows" all the locations where the
application's sockets would be placed, and just use RESOLVE_UNIX access
right (or nothing if it is not supported).

(The following is a bit of a side note, not terribly relevant if we're
deciding to go with the patch as is.)

>> [...]
>> Another way to put it is that, if FS-based and scope-based controls
>> interacts in the above proposed way, both mechanisms feel like "poking
>> holes" in the other.  But as Mickaël said, one can think of the two
>> mechanisms not as independent controls, but rather as two interfaces for
>> the same control.  The socket access control is "enabled" if either the
>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX access is handled, or the scope bit
>> proposed in this patch is enabled.
>>
>> With that said, I can think of some alternative ways that might make this
>> API look "better" (from a subjective point of view, feedback welcome),
>> however it does mean more delays, and specifically, these will depend on
>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX:
>>
>> One possibility is to simply always allow a Landlock domain to connect to
>> its own sockets (in the case where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is
>> handled, otherwise all sockets are allowed).  This might be reasonable, as
>> one can only connect to a socket it creates if it has the permission to
>> create it in the first place, which is already controlled by
>> LANDLOCK_ACCESS_FS_MAKE_SOCK, so we don't really lose any policy
>> flexibility here - if for some reason the sandboxer don't want to allow
>> access to any (pathname) sockets, even the sandboxed app's own ones, it
>> can just not allow LANDLOCK_ACCESS_FS_MAKE_SOCK anywhere.
>
> LANDLOCK_ACCESS_FS_MAKE_SOCK is only required to bind/listen to a
> socket, not to connect.  I guess you was thinking about
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX in this case?

In this "allow same-scope connect unconditionally" proposal, the
application would still be able to (bind to and) connect to its own
sockets, even if LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled and nothing is
allowed to have LANDLOCK_ACCESS_FS_RESOLVE_UNIX access.  But a sandboxer
which for whatever reason doesn't want this "allow same scope" default can
still prevent the use of (pathname) sockets by restricting
LANDLOCK_ACCESS_FS_MAKE_SOCK, because if an app can't connect to any
sockets it doesn't own, and can't create any sockets itself either, then
it effectively can't connect to any sockets at all.

(Although on second thought, I guess there could be a case where an app
first creates some socket files before doing landlock_restrict_self(),
then it might still be able to bind to these even without
LANDLOCK_ACCESS_FS_MAKE_SOCK?)
