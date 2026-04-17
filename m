Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B123C516
	for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444706; cv=none; b=fBxXtNCHfC21maymqh4qLIxmdUyA3qdPSw5sVq7lEoqAKVvYnOCLLE+kNSRlJ5d/IVU3RmUwYHgYvcBAb4cvyy1ml9m7Y9GKPRtueNS29KDh01nPRvRwH/4zYDEXBws7xT017AwQgyyQubLocbFjbY8akd2XEjI6mG0Q8zpe8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444706; c=relaxed/simple;
	bh=XQPvDOUBqGL5yLrbPZgix+AzB7PlZi0qZZ57sPKCqh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzXLfX9x1LkNDEdXZT3cadV6kj96l+ljDyWoYN9/OgJp2EeGbQjyrltJwUfFIZAZJ4QdW77mGM6eqGp9pt6BEX3yVoP1re7CFGZq313GUboAPfG1HPSyjBw545quuF6yo6slzqHCF8l4si+jkwGIHjj3sVINDDDdApaw5819EfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK/QAaUW; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK/QAaUW"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79db5e18ac6so21422017b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Apr 2026 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776444703; x=1777049503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mthWbvJo8IBMcus1WaUcDoRStgqS1tIgAGD3vbm8lg=;
        b=iK/QAaUWyE51ITaxDsZRqBs8saimtkvfYnXoy33HzFrRI0O2t3xMkkLfFSNomVgqKf
         4lI9avgV46WZ+9pngLLtyuS4TqfQU+Xb8GNHQIMYuLFU1AONqneCfAemzlMHt0L2b3YG
         BHLdRM4aN9CY92OsOnCQ0/uaffCdafmFoV3sINboOuU2SKieN3AuYZeaDZHv8E92L2O1
         hmnoIOUX6jA14MKWDfJXJjB5qcv3EWNUyzWzRhaO+Q2mSEelNF8PoWpdJdyAon1tSY9U
         8M3HUk4DbDlADCHLaFu0bT3o5CzN2I9b6WnL3hqIKcyAcu4RY9V5pFJlNoYWRzULuLXO
         Hukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776444703; x=1777049503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mthWbvJo8IBMcus1WaUcDoRStgqS1tIgAGD3vbm8lg=;
        b=A4hLAu9bfRe/n5ZjWFPWx9xFRHi8zZDW9m/zqgi8bTgKs5ygoA55kMcps6LPu+kCUo
         GVADhtzoxlclYxMEmn74t/Q0pEC+Qc7A0n1viqdt1BFCHT5xahR88eauV2d5IdCmGQrY
         g3HM/y0k5NTNXGK0xsQw4Jqif7RDt4UqA9reS93CR52itlK/8TP7yMtFnVmNcBYP8Cv0
         FDTk56/YAQI9gK8nJjnolWGPyLBeZDDxjiM4NDepWXmiXXBoRJDOpmxB9pb32+oE43Ld
         k5KxTot9zpZ4m2NALDTwDLCaXeX5jYw7we9oWM19UEJNqjLHypF5168s7PGfoyfpzW2Q
         DnrA==
X-Forwarded-Encrypted: i=1; AFNElJ9u2urPervFsTB6gQ2F8a36SmJHKly0B3RkJ9v+SY3SYEAWbWZlB4LNWC3whglW9FRjxvvHnduqkrdRsdmjAUXx0s7AFLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfRmVWN5ORUpj3DHBuK0z7MgMcVsZBf15FDjst7+gckrHSrEtT
	PoxNpi39X0gH7nM/G79O3GpF512r2QjwtUlv94F8xtv1AQTsg/V00D09
X-Gm-Gg: AeBDietiGTwkH0ioMpgyMa5GKgU8hmJ9+h4Jzox8KXr3zRluotd9baFw3tfNahdY3in
	laIL/KsiLhKH5ymyunkgnJrquWlb6fFvuoEOQzQGbrJT8In1CE7bMnVEOizP9CUTs8MNjIsHcfG
	B7McBZoudfu6Y/mk2KCBHXBDNipAJkq1D38+l4YDt8TdyWucH1J3WdbMsrIxUMm27IhALIeDmTL
	0JyBeXpYJf584uyT6KfiXVB2t/tXciFyurrW+UQrjQMMdR0RAB13J1Au6q+Fg0a2/PDhBcDiNBU
	1L1BMTO5y4z6Wo0wxReuvN8wb6gjEqpIk5RXZeg7hWKl+oh/F02/feQrlC1aMWcIzM9i4ui/VFk
	vr0Qzzubog36htFt1HfyGBWFu7ljdk82tLqP4ejYRnVGhpBSj8Ko/63E9rUIbnbodc1h20t0WEN
	/QpssjzIXFUlFUBir1DSik8Fgppq0q22ilLhDyLSO0D6MFoJ/ot8rCNU71F5bJvC/LK03b
X-Received: by 2002:a05:690c:9990:b0:7b9:f136:56d8 with SMTP id 00721157ae682-7b9f1365e67mr19384947b3.30.1776444703340;
        Fri, 17 Apr 2026 09:51:43 -0700 (PDT)
Received: from suesslenovo ([129.222.87.6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bb32sm8723277b3.30.2026.04.17.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:51:42 -0700 (PDT)
Date: Fri, 17 Apr 2026 12:51:40 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, kpsingh@kernel.org, paul@paul-moore.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org,
	gnoack@google.com, jack@suse.cz, jmorris@namei.org,
	serge@hallyn.com, yonghong.song@linux.dev, martin.lau@linux.dev,
	m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com,
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Message-ID: <aeJlHIoSjVPmccDx@suesslenovo>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com>
 <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo>
 <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo>
 <20260417.ohgoh0Eecome@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417.ohgoh0Eecome@digikod.net>

On Fri, Apr 17, 2026 at 05:18:05PM +0200, Mickaël Salaün wrote:
> On Fri, Apr 17, 2026 at 10:09:13AM -0400, Justin Suess wrote:
> > On Thu, Apr 16, 2026 at 04:47:40PM -0700, Song Liu wrote:
> > > On Thu, Apr 16, 2026 at 2:53 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > [...]
> > > > I don't think we can pass the FD number via a map, since the FD is
> > > > process specific. And it needs to be done in a way where we can lookup
> > > > the specific ruleset the FD points to safely.
> > > >
> > > > So we'd need some other way to load the ruleset from a file descriptor,
> > > > either through a new userspace side BPF call or similar mechanism.
> > > >
> > > > Is there some other common pattern for FDs --> kptr I can follow?
> > > 
> > > I didn't find an exact example like this. There must be a way to achieve
> > > this. In the worst case, we can add a kfunc for this.
> > >
> > 
> > I think new kfunc is a doable approach. I could make a kfunc taking a struct
> > *task_struct and an FD that looks up a landlock ruleset within a given
> > task that returns a trusted kptr.
> > 
> > Something like:
> > 
> > struct bpf_landlock_ruleset* bpf_landlock_get_ruleset_from_fd(struct
> > task_struct* task, int fd)

Thanks Mickaël and Song,

There are definitely pros and cons to both approaches.

I think it would be OK to have a dedicated map and indeed cleaner from
the userspace side since there would be no intermediate step to find the
task and lookup the fd since that would be handled by the map_ops.

Cons of the new map type:

The main issue is with the new map type is then we are limited to the
specific data structure we define in the map. For instance if we want
to use a hash or other data structure instead of an array to store
rulesets, we'd need to define variants of the landlock map type for
all data structures.

So this kind of bungles the "data structure" and "data type" layers.

Pros of the new map type:

The ruleset_fd conversion would be implicitly handled by the map_ops.
Userspace could insert the fd and bpf would not have to deal with it at
all.

Cons of bpf_landlock_get_ruleset_from_fd:

Awkward conversion step. We need to find the task of the original
ruleset creator and recieve the fd before looking it up and converting
it to a kptr to the bpf_landlock_ruleset.

Pros of bpf_landlock_get_ruleset_from_fd:

We can use any existing map data structure to store our kptrs.

Not having a dedicated map type simplifies implementation.

...

Appreciate the feedback from both of you.
> 
> That looks like a hack that would not handle FD's (object) lifetime
> (e.g. what happen when the task is gone?).
>

If we take an underlying reference on the ruleset backing the fd, then the fd
being closed shouldn't matter right?

This is how the lifetime management works for that
bpf_landlock_get_ruleset_from fd, in my draft implementation prior to
the RFC:

  /**
   * bpf_landlock_get_ruleset_from_fd - acquire a Landlock ruleset from a task FD
   * @task: task owning the file descriptor table to look up
   * @fd: Landlock ruleset file descriptor in @task
   *
   * Returns: a referenced opaque Landlock ruleset, or NULL if the FD lookup or
   * validation fails.
   */
  __bpf_kfunc struct bpf_landlock_ruleset *
  bpf_landlock_get_ruleset_from_fd(struct task_struct *task, int fd)
  {
  	struct landlock_ruleset *ruleset;
    /* does landlock_get_ruleset and increments refcount */
  	ruleset = landlock_get_task_ruleset_from_fd(task, fd, FMODE_CAN_READ);
  	if (IS_ERR(ruleset))
  		return NULL;
  
  	return (struct bpf_landlock_ruleset *)ruleset;
  }

The landlock_get_task_ruleset_from_fd increments the usage with
landlock_get_ruleset. (This may sleep, so it must be tagged with
KF_SLEEPABLE)

If the fd is closed before landlock_get_ruleset_from_fd, then null is returned.
The verifier will force the program to do the null check b/c of KF_RET_NULL.

__kptr also have destructor kfuncs. So if we get the reference in
bpf_landlock_get_ruleset_from_fd with landlock_get_ruleset_from_fd, and
put the reference to the ruleset.

The destructor path looks like this:

  /* Define ID for destructor * /
  BTF_ID_LIST(bpf_landlock_dtor_ids)
  BTF_ID(struct, bpf_landlock_ruleset)
  BTF_ID(func, bpf_landlock_put_ruleset_dtor)
  ...
  /**
  * bpf_landlock_put_ruleset - put a Landlock ruleset
  * @ruleset: Landlock ruleset to put
  */
  __bpf_kfunc void
  bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
  {
	  landlock_put_ruleset((struct landlock_ruleset *)ruleset);
  }

  __bpf_kfunc void bpf_landlock_put_ruleset_dtor(void *ruleset)
  {
	  bpf_landlock_put_ruleset(ruleset);
  }

  static int __init bpf_landlock_kfunc_init(void)
  {
  	const struct btf_id_dtor_kfunc bpf_landlock_dtors[] = {
  		{
  			.btf_id = bpf_landlock_dtor_ids[0],
  			.kfunc_btf_id = bpf_landlock_dtor_ids[1],
  		},
  	};
  	int ret;
  
  	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
  					&bpf_landlock_kfunc_set);
  	if (ret)
  		return ret;
  
  	return register_btf_id_dtor_kfuncs(bpf_landlock_dtors,
  					   ARRAY_SIZE(bpf_landlock_dtors),
  					   THIS_MODULE);
  }

Good reminder I need to include a test making sure the ruleset
remains valid after the FD and/or task is closed. :)

> Why not using proper typing with a dedicated map?
> 

I may be misunderstanding, but from what I see, a __kptr DOES give
proper typing, __kptr is an annotation not a type.

This is what it would look like in an BPF_MAP_TYPE_ARRAY.

    struct ruleset_kptr_value {
	    struct bpf_landlock_ruleset __kptr * ruleset;
    };

    struct {
	      __uint(type, BPF_MAP_TYPE_ARRAY);
	      __uint(max_entries, 1);
	      __type(key, __u32);
	      __type(value, struct ruleset_kptr_value);
    } ruleset_kptr_map SEC(".maps");

So we get proper typing from what I see. (It's not like a __kptr is a
special void*, it has a type)

> > 
> > And tagging it with KF_ACQUIRE + KF_RET_NULL.
> > 
> > Then keep the existing kfunc for putting the ruleset and enforcing it on
> > a struct linux_binprm.
> > 
> > The BPF program would need to get a reference to a task struct
> > of the program creating the rulesets with bpf_task_from_pid for
> > instance. Then they could use the task_struct with another plain integer
> > map to store FD numbers and then use the rulesets or store them in a map
> > of __kptr objects for later usage.
> > 
> > Would this be more acceptable?
> > > > Basically the pattern I need is userspace must create the file
> > > > descriptor, BPF converts that FD into a refcounted kernel object, and
> > > > even if userspace closes the FD BPF needs to hold a reference on the
> > > > underlying ruleset structure.
> > > >
> > > > (In this patch this was accomplished through the map_ops)
> > > >
> > > > Let me know what you think Song. I do understand the benefit of having a
> > > > __kptr instead, the refcounting is all there, and it would allow storing
> > > > rulesets in multiple map types. (and one less map type to maintain).
> > > 
> > > A new type of map for each FD referenced kernel type is non-starter.
> > > It is impossible to add UAPI for a specific use case.
> 
> This new map type is only about one file descriptor type, similarly to
> socket FDs.  From a UAPI point of view, it looks clean and safe,
> especially to deal with underlying object lifetime (e.g. reference
> tracking).
> 
> > >
> > You've convinced me. I could see a lot of problems if everyone wanting
> > to add their specialized maps, it would be difficult to maintain.
> 
> Is there another way to properly handle kernel object lifetime (not tied

The answer the the lifetime part is yes.

The kptr destructors and the landlock ruleset refcounting give us that
abstraction. (along with the KF_ACQUIRE/KF_RELEASE annotations and
destructor implementation)

> to the caller) and pass them as file descriptor?
This "pass them as a file descriptor" is the tricky part. It would be
very convenient if we could send the fd to bpf from userspace and have
it be implicitly converted (like in the BPF_MAP_TYPE_LANDLOCK_RULESET
implementation) in one step, but I just don't see a way to do that with
the bpf_landlock_get_ruleset_from_fd kfunc approach.
> 
> > 
> > It's probably best to keep the specialized map types to core kernel
> > interfaces only that are unlikely to change.
> 
> File descriptors are a stable interface.
>
No that's correct. I cede that point :)
> > 
> > > Thanks,
> > > Song
> > > 
> > > > Mickaël, do you have any thoughts on this? I have v2 basically ready,
> > > > although it uses the BPF_MAP_TYPE_LANDLOCK_RULESET it changes a lot on
> > > > the Landlock side.
> > 
