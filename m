Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43731AA81
	for <linux-security-module@vger.kernel.org>; Mon,  2 Feb 2026 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770069801; cv=none; b=aVngSy4n0SlkXF0po+ovE93iSVu9fpKmZrGbOM8vN36YyjOrG7g5dWEifroIYUz1mO+mBJcpvlYKUTnSV5OVeeqzpYEmp7UjB9VwOEVmpa47FjUyBr7s13ycxV00EkZsQxd6r0rItZ47EqbndQDzCMcSoVGSZ/sb+hAdjgzCJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770069801; c=relaxed/simple;
	bh=8bQCYHsRmkoU2X/rHyom1rqvw7DQc2bitXzLwUdjEho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KF4e3PON6wMNPBZAY4pYrlO5jodv4uAxu/HZoGSXOmgq5DbLa/wfZzEsBjKfw1Ntast/K2IBt+jpLCYK5SxUbIWWS2OmyuBzv92YcdSpoG2Py/Ym3PeXL81FfgDGqJCWr/GYLo65K5EoG8HFKkQIltofktIMuCnrFYkSfOSxJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDCLhbxQ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDCLhbxQ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7947cf097c1so41704187b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 02 Feb 2026 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770069798; x=1770674598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3QAbtxtAvzafy/aOsaVKylIphRN2KzRIppz8gGkRXE=;
        b=QDCLhbxQezQNUSVamWkSLSBM5v0jswwJ1vcZQq5BtyjfT03jA1etHr4m/25rdvV86Z
         F0azrVfuXJ7vhgC9519RVmTtRYsTkIU2ndnZgzGPWcg/wUPOGHgBvVKhSdseNFsx70j0
         Tts1QhAUmhmO6mCjxr1+gMM6K8AbiXH24qLpX0Zt7zZXon0vmWE/U6MA4e/T3MkjzT+1
         UzuLUMbYtMhXkF1gYFB/HUCcD77ejxcq8SrgWNCUGGVOCU/PeUCIdyeAp8EUjuu5rTJN
         Js0WnCj6BsTFYqTW5WjL5k+1q6u8IVfxaqOBR5Tly9MhRK78jsGPLibvatJqo03bwngB
         uZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770069798; x=1770674598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3QAbtxtAvzafy/aOsaVKylIphRN2KzRIppz8gGkRXE=;
        b=lriENF3gVL7M53SciGXnRkn/wKaS1bHDjhZyGPXrCczQ9wAZJ4FSEHF3lmKZw2GxPq
         iPBDIiIhTPq/xNI8dL+BqxTaYfi6YGNuwWpkzESb4tHWUoq1Bbt1TAoLAA4Iao7C8gUJ
         LAznLu/ISufWAwCPtg/98K3ACR762KXXguzYEeDlTbxSmZiFY1Ly6f01OjpmZ187/frO
         a2d8cAPk7/Nfi/GlVr0QiAWP1uttbPusI3brrKGU5emqU+ElNM71AsPjHswxsGjV0oVQ
         K/x4SzhVPTqy0fWiVsRDZsMoPzH1O8Ql0P+wWw0qWG+FRow3sVl/14LuC2+gqmZDdz+d
         PLqg==
X-Forwarded-Encrypted: i=1; AJvYcCWZdSSLHst7msKNmGtjmvm32002UUve7e0+QoijpnlT9F3Tw7J8rfG3H7Y0AatkXwhipXustfTguhO/46PneBjkh9o8n6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2j0myGh2xz8hxBVv/qqw/76+UFYrg+DqNY1BooX+zvq7rpHl
	8BCs6eat5wnnFnVZdBZ59JrBuzNfVR+N6uiLMIx2OHrJq8S/UsahtVm5cSJ+Kw==
X-Gm-Gg: AZuq6aLP0l2/snD/CUBIa7xathJJ5oObOQgdpZhgRC5IwvOD7/9Ww18F/OCRHgZi2q6
	3ObXLmV4d4yFRPvHv1YhAEv8PDHQGm4hdAnIWZlRaJDN6iE9Ujm04UWaxMWoDmkUOGXStxoFO9a
	hlDZJUY18Xlh2xno/Q4NoJUh+Bw2KeMjW1OJShpRoe05MkJx9f8x1N2DFoeFDkNYhtWsEAdrK21
	rqKV/ojOZUIMRtto8WAaR6F70oVE+uNENr95S10f1PA9uEt157TuHK+Upy929cuFFA8bxLanhQ4
	TV2g4wqdQTm3TnWbT8bZuptSNGdLHFdC7jzke2li6Wp17WInROwU3KleV1wvtRT+0jUTS2ynS/T
	BVhflXwkZNVP1FoqF4wLzaaRHNNkxYL/DgOqw/R5HrOySmvFs86nKUaR08YIonWUHovCyicIIdx
	OEebJqQWqlZKEe//Kh69mlNwlfSagYqMv9spKgGWQ3sy8aRCbczY+tFJ0zvS/R3Xs4WY1iDQ==
X-Received: by 2002:a05:690c:6f09:b0:794:e463:d086 with SMTP id 00721157ae682-794e463da54mr22355447b3.68.1770069798509;
        Mon, 02 Feb 2026 14:03:18 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794ec92ea46sm8013287b3.26.2026.02.02.14.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 14:03:18 -0800 (PST)
Message-ID: <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
Date: Mon, 2 Feb 2026 17:03:16 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Tingmao Wang <m@maowtm.org>
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
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <20260202.uu0oCheexahY@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/2/26 15:32, Mickaël Salaün wrote:
> On Sat, Jan 31, 2026 at 05:41:14PM +0000, Tingmao Wang wrote:
>> On 1/9/26 12:01, Mickaël Salaün wrote:
>>> On Wed, Dec 31, 2025 at 11:54:27AM -0500, Demi Marie Obenour wrote:
>>>> On 12/30/25 18:16, Günther Noack wrote:
>>>>> [...]
>>>>> On Tue, Dec 30, 2025 at 05:20:18PM +0000, Tingmao Wang wrote:
>>>>>> [...]
>>>>> What is unclear to me from the examples and the description is: Why is
>>>>> the boundary between allowed and denied connection targets drawn at
>>>>> the border of the Landlock domain (the "scope") and why don't we solve
>>>>> this with the file-system-based approach described in [1]?
>>>>>
>>>>> **Do we have existing use cases where a service is both offered and
>>>>> connected to all from within the same Landlock domain, and where the
>>>>> process enforcing the policy does not control the child process enough
>>>>> so that it would be possible to allow-list it with a
>>>>> LANDLOCK_ACCESS_FS_CONNECT_UNIX rule?**
>>> Yes, with the sandboxer use case.  It's similar to a container that
>>> doesn't know all programs that could be run in it.  We should be able to
>>> create sandboxes that don't assume (nor restrict) internal IPCs (or any
>>> kind of direct process I/O).
>>>
>>> Landlock should make it possible to scope any kind of IPC.  It's a
>>> mental model which is easy to understand and that should be enforced by
>>> default.  Of course, we need some ways to add exceptions to this
>>> deny-by-default policy, and that's why we also need the FS-based control
>>> mechanism.
>>>
>>>>> If we do not have such a use case, it seems that the planned FS-based
>>>>> control mechanism from [1] would do the same job?  Long term, we might
>>>>> be better off if we only have only one control -- as we have discussed
>>>>> in [2], having two of these might mean that they interact in
>>>>> unconventional and possibly confusing ways.
>>>> I agree with this.
>>> Both approaches are complementary/orthogonal and make sense long term
>>> too.  This might be the first time we can restrict the same operations,
>>> but I'm pretty sure it will not be the last, and it's OK.  Handled FS
>>> access and scoped restrictions are two ways to describe a part of the
>>> security policy.  Having different ways makes the interface much simpler
>>> than a generic one that would have to take into account all potential
>>> future access controls.
>>>
>>> One thing to keep in mind is that UAPI doesn't have to map 1:1 to the
>>> kernel implementation, but the UAPI is stable and future proof, whereas
>>> the kernel implementation can change a lot.
>>>
>>> The ruleset's handled fields serve two purposes: define what should be
>>> denied by default, and define which type of rules are valid
>>> (compatibility).  The ruleset's scoped field serve similar purposes but
>>> it also implies implicit rules (i.e. communications with processes
>>> inside the sandbox are allowed).  Without the soped field, we would have
>>> to create dedicated handled field per type (i.e. scope's bit) and
>>> dedicated rule type for the related handled field, which would make the
>>> interface more generic but also more complex, for something which is not
>>> needed.
>>>
>>> In a nutshell, in the case of the FS-based and scope-based unix socket
>>> control, we should see one kind of restrictions (e.g. connect to unix
>>> socket), which can accept two types of rules: (explicit) file path, or
>>> (implicit) peer's scope.  Access should be granted as long as a rule
>>> matches, whatever its type.
>>>
>>> This rationale should be explained in a commit message.
>>>
>>>>> Apart from that, there are some other weaker hints that make me
>>>>> slightly critical of this patch set:
>>>>>
>>>>> * We discussed the idea that a FS-based path_beneath rule would act
>>>>>   implicitly also as an exception for
>>>>>   LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET, in [2] - one possible way to
>>>>>   interpret this is that the gravity of the system's logic pulls us
>>>>>   back towards a FS-based control, and we would have to swim less
>>>>>   against the stream if we integrated the Unix connect() control in
>>>>>   that way?
>> While I do think being able to control UNIX socket access via domain
>> scoping is useful (after all, it is an additional bit of information /
>> relationship that "normal" filesystem objects doesn't have, and
>> applications using Landlock might find it useful to control access based
>> on this extra information, either to simplify the policy, or because a
>> generic sandboxer can't come up with a pre-determined list of UNIX socket
>> fs rules, e.g. for applications which places socket in hard-coded "/tmp"),
>> I do share the worry about how this might get confusing from an API
>> perspective, as discussed in my GitHub comment [1].
>>
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
> LANDLOCK_ACCESS_FS_MAKE_SOCK is only required to bind/listen to a
> socket, not to connect.  I guess you was thinking about
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX in this case?
>
>> Another possibility is to have this scope control as part of the
>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX rule itself, rather than as a separate
>> scope bit, via introducing a "rule flag" (which is a new mechanism
>> proposed in [2]) which I will tentatively call
>> (LANDLOCK_ADD_RULE_)SAME_SCOPE_ONLY.  So for example:
>>
>> - If the sandboxer wants to allow all socket access, don't handle
>>   LANDLOCK_ACCESS_FS_RESOLVE_UNIX at all, or handle it but have an allow
>>   rule at / with no flags.
>>
>> - If it wants to allow access to only the sandboxed app's own sockets,
>>   handle LANDLOCK_ACCESS_FS_RESOLVE_UNIX, then place one allow rule on /
>>   with the rule flag SAME_SCOPE_ONLY.  This means that the allow rule
>>   "UNIX socket under /" only allows connecting to sockets in the same
>>   domain scope.  Additional rules without this rule flag can be placed on
>>   more specific places to add "exceptions" to allow access to more
>>   privileged sockets.
>>
>> - To allow access to specific sockets only, not even the sandboxed app's
>>   own sockets, just use LANDLOCK_ACCESS_FS_RESOLVE_UNIX without this new
>>   rule flag.
>>
>> This is slightly more flexible than just the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
>> scope bit plus LANDLOCK_ACCESS_FS_RESOLVE_UNIX, as it allows the sandboxer
>> to specify where an application can connect, even with sockets in its own
>> domain, and it also nicely avoids the "what feels like two independent
>> controls poking holes in each other" problem.  But it does mean more
>> complexity (although hopefully not too much), as we now need to introduce
>> the rule flags concept, but that is required for some other proposed stuff
>> anyway - quiet flags [3] and no_inherit [4] rules, and the rule flags
>> design is in a good state I think.
> This looks too complex and would intertwine both concept, which is more
> confusing IMO.
>
>> What do folks think?
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
>
> Anyway, we need to decide if this should be merged in Linux 7.0 (next
> week) or not.  I'd prefer to merge it now because I think it works well
> and it's not a new concept wrt the abstract UNIX socket scoping.
> However, if there are any concern, I'd like to hear them now and I can
> delay this merge if needed.  This patch series still need a new version
> but that should only be about cosmetic fixes.  WDYT?
Regardless if you merge the patch series now in 7.0 or a later version, I think there is something to be said
about having the filesystem and scoped unix access right merged in the same ABI version / merge window.

As you pointed out earlier, the combination of the two flags is much flexible and useful to userspace
consumers than one or the other, and if the features were merged separately, there would be an
awkward middle ABI where user space consumers may have to make compromises or changes to
sandbox between different versions or change application behavior.

I think the discussion has died down on the security_unix_find hook for
LANDLOCK_ACCESS_FS_RESOLVE_UNIX [1] [2], and it seemed the general consensus was favorable.

The series for LANDLOCK_ACCESS_FS_RESOLVE_UNIX is pretty small, and feedback on the last version
was pretty quiet as well. So maybe it's worth a final look into. [3]

(PS: I do think if they are merged together, there should be tests specifically for the combination of the
two access rights. I'd be happy to draft some)

Justin

[1] : https://lore.kernel.org/linux-security-module/4bc22faa-2927-4ef9-b5dc-67a7575177e9@gmail.com/
[2] : https://lore.kernel.org/linux-security-module/20260110143300.71048-4-gnoack3000@gmail.com/
[3] : https://lore.kernel.org/linux-security-module/20260119203457.97676-2-gnoack3000@gmail.com/
>
>> (btw, when I say "sandboxed app" this can of course also mean multiple
>> applications in the same sandbox, e.g. like a container runtime as Mickaël
>> pointed out, which raises the probability that just having
>> LANDLOCK_ACCESS_FS_RESOLVE_UNIX would be insufficient, e.g. when bind
>> mounts are involved, or other cases which I haven't thought of right now)
>>
>> [1]: https://github.com/landlock-lsm/linux/issues/36#issuecomment-3693123942
>> [2]: https://lore.kernel.org/all/f238931bc813fc50fc8e11a007a8ad2136024df3.1766330134.git.m@maowtm.org/
>> [3]: https://lore.kernel.org/all/cover.1766330134.git.m@maowtm.org/
>> [4]: https://lore.kernel.org/all/20251221194301.247484-1-utilityemal77@gmail.com/
>>

