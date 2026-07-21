Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9137473A
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2026 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784670923; cv=none; b=eQmZNTWyVjfBppO8y27sr/vAVAbuQQ6oyH2PgRnt+OtYr0FZi5Ruyr0zio1xE2PajQkJp/tjGXFvXtbm9k/GYx9qRkle7TgJeaj5L51rG2bczkyUxBt01lU/AmELn168SwrA/HYC05NIOLlZcWOnfSko/rklEkt6KKPrXx+rYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784670923; c=relaxed/simple;
	bh=f1hu6tLo0+BCNNJKKgvm7cAlnDLnuYkIvVYXS0I8Rj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVGUTvlITWyvPOhALp9keaVSd1w95wAfLhZ598VRF+31TCdekTby7J/iASr+K6zFvM2TVKNSP7yKcMq1AdrwaCVn1LD3KEEPiTwOMyTeaUEHWSUBW1wUy6DoEEV2F4CY069VDDkBm721VILsUVUXut3b/9RXp4z0Vanzl608CRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7wj1cRo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7wj1cRo"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e6f0b4610so120938687b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 21 Jul 2026 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784670921; x=1785275721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aor1gy3cPPxEdvRqiUc0A+Tvnlrd7s+z5uJMPv36HgA=;
        b=Y7wj1cRon7BcbtH1nKawZlLwFcFJFtAEg08zaiC+s3prPrlHepxJBA/K/cAxUzImKw
         O63DqIeFDgZqHFpjHWECiItgcwTtFxJPAAqgjvlId0Iv79tGA9oz7sIxcs5c0+U70Axj
         GNrLi2eltNayXwiyPgan0WBOlhm7NsOvAd2Ek9dl/IxtgWdm4r0tMDy7OLJC+S3bTTSB
         ocEZyrAv3LySkuOJ6ckt0zTPjcH2SVoRObnSen6BYaHhKRsCohSzvrGi5QouGO/V41Vn
         lnSzNH+VnLwiZ7j0mzynR2UeChXVQmhl7dBPKoL0Lc7kB4kZ9k2XS1Ahbl65m8NHum9l
         q/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784670921; x=1785275721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Aor1gy3cPPxEdvRqiUc0A+Tvnlrd7s+z5uJMPv36HgA=;
        b=A6cbvo3BU/5Iil/EZsqf5Didv9TEswSZI5r/ZV8aDSokL+q8LXM5NK5sqHThS7sKgG
         H3XeVgd+gxwCToB7qKeuxh7NgboADqLYOyLrJ8QODyFdYjBRsFQ83WPqyvxHd100m/dt
         +A8Am6hF6lCQt0WOEUATekb5SgVX55JgZmmK84Ax4u/x9xNLNqoe5mRsgoXbv8jC+o5x
         LzMhacVzJJa4Zrxd6QiCtWroPLf6p9oOd6ReQ3lwQD6Z8vtstOjG6uqAcYyaSxI5hf/K
         nAHdJOMqOlJ0eECT8U3yppm08BphUe+3lQFCEpIZrgCfV7Abm0vzrSeLahiB8eHcKET+
         wU5g==
X-Forwarded-Encrypted: i=1; AHgh+RotHMiZqAd0i8/Z49O4aDLPpTxttRXoWh1LTDMyyIHge8Hm/GzopvMsfm+JKBqpcYgcHQwlmFkvhfl4Fx+u8EfeYMelU5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQZW9I7MsYtdP/jp2461fT8jdzebuVoHLmiUnChliRhBT9LFI
	2MU3ZLRXzcE7MKV69hZ6NTYEAJKrk1V68s2xuPy2m/W6o67rYhFqEWhG
X-Gm-Gg: AR+sD11utgDqo/ZIAWAiQIIhGkaRoS16FPhfBbIJyvb1WRDDHZ/yuSffCsXELdFVAT5
	g3dUYAiyq9WbhSsfE+S2jWqcsc6I7KYrnsks23QPWhGZdg45b0JahFkiwUlZSCCrmGvBeBfJyA7
	eOoAIVJT9xqoh0YcjVzw7SKOwpA2ppXjVVD0cZO7QBsbPf0tCh5ijNihWRMv8VSl27AHyFCqfoW
	Nzy7x681RsGVlyttzOjEXQK0zNt+ElUCPrnJ8a87RejVEjzAP3D/P/vJy49BShFiykeGspwGF2F
	ZR7ZF9LlqAkIIWGBQ9PqDNwCeK6ggemAoe6GnaETaEE0NmmkatLkPyU9KSAlHnEjFthP6yv1KFs
	VUF2TMEOM0OTSaH3PPwXpvB4b3Zf8hTfdqCuL5a4wWA2WGFHkiIJnkhInUTpJ3brwqg/gIDAlr/
	4iQ4TNZq5DD35CMKWp1F55HT+WBzC8w1uBODpQ
X-Received: by 2002:a05:690c:7245:b0:81e:d032:f3dd with SMTP id 00721157ae682-81ef26a5bbamr60101417b3.45.1784670920807;
        Tue, 21 Jul 2026 14:55:20 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:858f:ad8f:8b97:19da])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33f35417sm4111957b3.47.2026.07.21.14.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 14:55:19 -0700 (PDT)
Date: Tue, 21 Jul 2026 17:55:18 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <al_TBtXYUNGLZHC2@zenbox>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox>
 <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <akVbLGYyafZq_93v@zenbox>
 <CAHC9VhRp6pvQXskNU0FXBkDw=MAF8Ht1Mk7BbUeU8JnEkSk52g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRp6pvQXskNU0FXBkDw=MAF8Ht1Mk7BbUeU8JnEkSk52g@mail.gmail.com>

On Wed, Jul 01, 2026 at 02:33:26PM -0400, Paul Moore wrote:
> On Wed, Jul 1, 2026 at 2:29 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > On Wed, Jul 1, 2026 at 8:52 AM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > On Wed, Jul 1, 2026 at 6:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> [..]
>
> Please keep in mind that the LSM framework API needs to be reasonably
> generic.  We've got some general guidance on adding new LSM hooks at
> the link below:
> 
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-hooks
>

Howdy,

I'd like to reopen this conversation with a fresh proposal.

Apologies it's been a while.. hope this isn't too long.

I've re-read the LSM design documents linked above, plus some of the
older discussions where similar things were proposed, and this is a
redesign I'd like feedback on before wasting time prototyping.

Background
==========

Refresher (since it's been a minute):

The original RFC exposed kfuncs (non-ABI functions callable
from sleepable BPF LSM programs) straight out of security/landlock, to
apply a userspace-created Landlock ruleset to a binprm during exec.
That skipped the LSM framework entirely and was basically a direct
line into one LSM.

Paul and Casey, as I understand it your objection breaks down into
two parts:

1. LSM configuration/policy interfaces shouldn't exist outside the
   LSM framework. If every LSM grows its own kernel-internal API
   surface it gets messy and hard to refactor.

2. Anything at the framework level has to be reasonably generic. From
   the design docs:

   "Hooks should be designed to be LSM agnostic. While it is possible
   that only one LSM might implement the hook at the time of
   submission, the hook's behavior should be generic enough that
   other LSMs could provide a meaningful implementation."

The proposal here should meet this better.

Proposal
========

Broadly, I am seeking to propose an LSM framework API for kfuncs.

This would be ALL through the existing LSM hook interface.

Instead of individual LSMs exporting kfuncs, the LSM framework exports
all LSM kfuncs and dispatches them to LSMs through generic LSM hooks.

Here's an ASCII diagram (hopefully it doesn't get mangled)
of the framework:

     bpf_landlock_restrict_binprm(bprm, ruleset, flags)
                        |
                        |  strongly BTF-typed
                        |  (struct bpf_landlock_ruleset *)
                        v
   +-------------------------------------------------------------+
   |                       LSM framework                         |
   |                                                             |
   |  security/lsm_kfuncs.c            (owns all kfuncs)         |
   |     - kfunc filter: prog type / sleepable / LSM enabled?    |
   |     - type erasure: ruleset -> void *policy                 |
   |                        |                                    |
   |                        v                                    |
   |  security_kfunc_enforce_bprm_policy(LSM_ID_LANDLOCK,        |
   |                                     bprm, policy, flags)    |
   |                        |                                    |
   |     lsm_for_each_hook: | dispatch by lsm_id                 |
   |        +---------------+---------------+                    |
   |        |               |               |                    |
   +--------|---------------|---------------|--------------------+
            v               v               v
      id != lsm_id     id != lsm_id    id == LSM_ID_LANDLOCK
      (skipped)        (skipped)            |
                                            v
   +-------------------------------------------------------------+
   |  security/landlock                                          |
   |                                                             |
   |  LSM_HOOK_INIT(kfunc_enforce_bprm_policy,                   |
   |                hook_enforce_bprm_policy)                    |
   |     - applies ruleset, staged to bprm_committing_creds      |
   +-------------------------------------------------------------+

      no LSM matches / hook not implemented  ->  -EOPNOTSUPP

1. The LSM framework owns the kfuncs.

   Individual LSMs never register or export a kfunc. All kfuncs live
   under security/ (say security/lsm_kfuncs.c) and go through the LSM
   tree. LSMs only ever implement ordinary LSM hooks, via
   LSM_HOOK_INIT() like anything else. No LSM touches BPF.

   The kfuncs break down into two categories:

   a. kfuncs that talk to the LSM framework itself and no specific
      LSM. There's already userspace precedent for this category in
      the LSM syscalls (lsm_list_modules() etc). To be honest
      category (a) may not need any kfuncs at all to start with; I'm
      including it for completeness of the model :)

   b. kfuncs that carry a policy operation to one specific LSM.
      Applying a Landlock ruleset to a binprm (this series), or
      hypothetically loading an AppArmor profile. The kfunc from
      this series is one of these:

      bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
                                   const struct bpf_landlock_ruleset *ruleset,
                                   u32 flags);

2. Either way, every kfunc call passes through a generic LSM hook. No
   kfunc calls directly into an individual LSM. The shim in
   security/security.c (or other lsm framework owned file) is the
   only caller of the hook.

3. Category (a) kfuncs map 1:1 onto an LSM hook. The framework
   dispatches to every LSM implementing the hook and returns the
   collective verdict, same as any hook today.

4. Category (b) kfuncs follow the existing
   security_getprocattr()/security_setprocattr() precedent: a generic
   hook dispatched by LSM id. For the Landlock case the shim would
   look something like:

      int security_kfunc_enforce_bprm_policy(int lsm_id,
                                             struct linux_binprm *bprm,
                                             void *policy,
                                             u32 flags);

   dispatched by lsm_id:

      lsm_for_each_hook(scall, kfunc_enforce_bprm_policy) {
              if (scall->hl->lsmid->id != lsm_id)
                      continue;
              return scall->hl->hook.kfunc_enforce_bprm_policy(bprm,
                                                        policy, flags);
      }
      return -EOPNOTSUPP;

   The hook is generic in that any LSM with a notion of a per-task or
   per-exec policy object can implement it. Landlock implements it
   like any other hook:

      LSM_HOOK_INIT(kfunc_enforce_bprm_policy,
                    hook_enforce_bprm_policy),

   Critically, Landlock only receives hook calls with a matching
   LSM_ID, so another LSM implementing the same hook never sees calls
   meant for a different kfunc.

5. Type safety at the kfunc boundary is preserved.

   Note the asymmetry between the kfunc signature and the hook
   signature above: the kfunc the BPF verifier sees stays strongly
   BTF-typed (struct bpf_landlock_ruleset *), so BPF programs get
   full verifier type checking and can't pass an arbitrary pointer.

   This also avoids a user facing multiplexer.

   The erasure to void * happens inside the shim, after the verifier
   has already guaranteed the pointer's type, and the receiving LSM
   (picked by lsm_id) is the only LSM that will ever see it. Think
   the relationship setprocattr has with its string payloads, just
   with stronger (BPF verifier-enforced) typing on the kfunc side.

6. The shim checks that the target LSM is actually enabled at
   runtime, and that the calling context is OK (i.e. implementing a
   kfunc filter). This is centralized to make it easier for review
   from both LSM and BPF subsystems.

BPF Side
=========

Alexei / Song / Kumar / BPF maintainers,

Even if this proposal doesn't touch kernel/bpf/, I still would
need to hear your feedback / review on this every bit as much
as I need to hear the LSM side.

I think the kfunc / kptr model with strong typing fits this well.
We can have reference counted and strongly typed policy objects
for the LSMs, and kfuncs give more flexibility for API deprecation
as they are not considered to be ABI like helpers...

Obviously any new kfunc / kptr would need to be reviewed by BPF tree
especially with regards to kptr lifetimes and the calling context.

But hopefully this centralizes the interface that would otherwise be an
ad-hoc mess of individual LSMs trying to define kfuncs willy-nilly and
causing regressions.

One particular point that I would need to know is what should happen if
an LSM is not loaded / compiled in, but the kfunc is called. Is a
verifier rejection acceptible? Or is a runtime error more appropriate
for this?

Thanks,
Justin
