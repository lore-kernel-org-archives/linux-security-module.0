Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D71A2C11
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624558; cv=none; b=XuyUDt6vOO8WC4YQjhKmQ6Lq+kPtDV7zNMGzTRlgPjZCaRHG+EkefEY4iTzlZF46oWOGElptMLbdNU1xSzMIuTWwIBdWXgFJq/B9jv3nPQtDm77weoxAIt3deMqj/UPtfVJoEbl4YhsUaPU1drRJRwTNa2H6g4J6CZng2K+E+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624558; c=relaxed/simple;
	bh=eFawQOwx0t+3UujBh4Fr3uZplLDO6ijeohvSoG1jjw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K83mg9DzwyCs94/G8d/1Kmh/h1OT5P6IAYj5op52PaFkIS6IWRlK3TlsjAUQ0B6bPtJ8NVoAviaZypbmJg2erje6C6N0Nj5YeT0r2s1gXmz4m0AeEjWelbQx0Op1t6jUMlzHPSuqG2HgBSIqYRdxmvjz9p4X/76sDlg+GsmaczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QWhZCCSB; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QWhZCCSB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748624549; bh=79d3wEeq0DfVMh6u8bOiCnavXHOMOyotm1cKZBRGi5Y=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QWhZCCSBuwDP7kPLIM/0CWjUqndI2T6bDlc7PYQJaZmE6QZUehbrx7DAtynsnnxK0msL1vFmM9Bn+aitxHAednWPRs+kIxXJ5fPbytDN662ElDGGAJGw5OQJfFkhYj/6y5l6pUyIgX9bOzBvlj8nyi5dm9Y8E/AKWvEspUQq4s88UNUI1CfBpZJJuQU778B/RWBiNAOWvpKrGrk0fRklciV4T1Dvfb0c5krcyW6aeNmQPJZ9edB0UpsVjUJeTvhGme7eT6ROnTkP0xtX0F1u8ZsTJbh08GkSgLtJbnMMQVUHAVJ+XGnodCuD2hBmZXVwg1LObF5tKmChkpd2gr4Cvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748624549; bh=OBxQJ/euDArHKJQHy3j4rdBlSa+oz/gvdYAId9UEBk6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MpKZ/p5JDnmgvaCgKCgosA24kFJLP0ThgXfwFsatG1oYxEcGOXhAbkKq0K2p83c1e6YzACDaiCmudYIxR2B2wSBRq3HWNQ4x1zFdTrk2I1l+afV2aKWd13c484q1/6DxneACdtv0ml/8xpGBmG5DlW81GIth++xjEH80QJJp8k+QJnha+TZkPGUFCv7AhJx5ESuHC3yZPLLBmb1+oHsqKFxJvnABnJSxpIGH+cQQQwwIjNEsubcF4I//+4JlIVeFxFsjGJmR33We8Ao19B8jNChawZln9GvgcPmM3yjmMXYRp+cx+gUYJXMmRmvyQsurvFPa/K4/2EiMwdr0mmAJoQ==
X-YMail-OSG: 9H8usBAVM1mXvzZYu6juGgF7x128gp_YEHcGoEQLPh05TEOjpl2CxBe_i14A5.V
 Ezg9IR141c6Z5HQtIs5ixMLu7Cnd3tsQ2kPdxaVITSLjZOkziaCx4jofNbNHBKs5l51WAPJ0zu85
 2qKnq4ZHSo3MY.dcrmRBmdBkhogG1YqMVtJ0yublc8HpvuN7A1biW9WUP2KSs_6osytGi7gZAD99
 SeH0xEHlWke3_PUW7twBOZYm6IzZHtTGZxBQq1R6yOYhBblW3q69ooJtJYstiSa5Erz5I6vVeMrN
 NUuI9RqcfrdIVjG5euyRU4uGTY6zgvXHHgvVUBSnDmZOsfq73EvQY1BwO4ggakazLclK8vo_cHUl
 9RaOm5re2dl0w7BdxzcVtg_jiVLhATGQ21sYaqXebwXQqdymnyB11sYmR05KhG5No9rQO8yYtz9l
 wgAE5s9ss0tGT2ZIZTIutU.pyMLc89zeDHo47foBKqX6JUD1gZAREJMVG_fEb4zlSXnYO.ZMx7J9
 FjyCVqLGNVeOid6iZ9sX09lZjcWMkr_K6Y723kOsXcrnTthyy0YanDWdvsKQTlMkjWO0PYrny.Pq
 zgnKopb4cCkXYPNO55I5n43REkCSpzrhz7umZ4D.HAyM69UF32lwQSUws3lWQU8lXhK_5Wjz8G3Y
 ar8Et9NPkg7RR6z2YYzUM7BYAoGvkUfGf1AmEG4lq9JKySYNwhvCGtGYo6_tM1_d.Ew9pIFyInyI
 1.L_IqI76QV1ZBEl2RVbb5agcW7R35pBpxIihwTLExFlRzkbgchJZGNteArKl2nk0fQvptEZlToE
 lBXYZC2MwKKyDOavr4rnPpN6uubCYUrEfSdMcyTaFlC9EUJeuzex0L7BLSAmr5ZcVZIAIL4B97Xi
 o2_JiEU2lAGRz5tSpnyIRG14sPPC8ojyyOMTO0yh0baDcQaQM5IGkuasb1_gTva9xTR.UpY.00aV
 ML9q7toHdmKZFnG_1xCsBnl.7FeBYZm9VskRNpLT.kJ6DwvDKvSnxfbM6m1C3EpDO5PKw_7.TWlB
 48DIDGv1GfCHygXXmIZy_HBF6JdYCq7CMLhIVT8mN1mqGZx4ovNtidTR2gqm1yMYgFg7Ik6QCXGM
 5CO1LVwOtlJGtBoieObslgXR3hB_wL2d2eoIwg0IriWgdYgaKiA9OKj70npmowWAeascm_pV04cz
 dCM.yXjL3ml3Zym4hhWGrBPjtMwQp24pAv4fM3xVMSUZ2N_ZodU8HD6.oHc2xqOwdCfeHmXNBGF4
 GvF6oV1WaIuS5MezqdgnjfYpqEotIil7ZX4Yv.D7kuLDXY760GNQ6BkIDDvGWSe86wryhh0E50CO
 Boj7nJDg3U445rPvlZxyehMpeGZXyEZMo3vmHo_stdkC8K8OYwYKjOiKlN19ApGOgSlCa9VmH9Fj
 41grxKTuX_boyBqfoQaN4UxQwSBeATt_dE.t8N8DSSaJgKTjOWk.FQQVeWYbhOmG.MEFSmbQ3cJX
 nIgtcypZriNNft8a7oNiutuHTZJlQc8u3JXpsbDwh6sBVr5TKiNlScc2J.DIi64Q5dwJphs93EGj
 yJGw3e.ikVbWPFWWXRgJWkFbwUFj2kJNq2vIMoOy.t6RI1yzmRUBi0LN.ZFSzEBql1rS34QHvSoV
 F3s0_..cQKvvbdjqzuT.bZHL.lB_IyPCEpunQcDviWnaNpGZsriCizAK3.AxWgq06ewPnsWjxLUG
 yb1oBoG1M5kG8Uxd5uew.fOEgl.3p6w8mPU.5xYgqrhVfHnGJTXOZQGD5lJXhVmiClb2Y6OfKfrt
 .rz3xPzKuxsgm5MOP9mJdfy1K.wy58TmiTYQN9lR.xj6oc2cDUXF28JiPajKhBJoGcL7BGuEA.zL
 vua1v9UiadmBKzBchj9ixbCjy3tL7ocUOESUuPJqdrSNuejhkPlKFYIfcDDodA07kp4pmeLTUl.i
 nqYJLwv9KKBLkvqvi8n.dD0vkFDZkcTFwJFokXBTWtPoKe2h8I8Psah7OtlQeagqiH1RRFV7G_Ut
 FchLYQE2qtwfN8Ak0wE3MKQb7YNgYClxi02f7fJuKdxbtSuflnbedsw4JezUVNHlhkYqrhcrIbyw
 nftjkQe9Qg3P0NfXbOfdCjglc5jyP8tBDo_zWUDeRFzOmEz6Xz4QrH5mrKgk7aNp4QOjIIpmhmO6
 NeAEanx0_j87qvrAZfVx4_fDH42deiO_otLJCThCcMdQn.0oKHoqR63oTNZK.oYNejbjm7l4E.0b
 7dc6c.gsCTJbKePlbXIv6Y.OBDbkcRGGjIlGviFVLQcPyAAicMJfeh3fC_d6F2RswhgyJeBOqWYl
 PYShwye9cFFEaAn6PBHiU3oqLej0zY_j_
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e297110d-07b8-4426-97e4-592aefd09b3c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 May 2025 17:02:29 +0000
Received: by hermes--production-gq1-74d64bb7d7-r5xbr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 55de6f3c173c43eb92ce6bb799c178d9;
          Fri, 30 May 2025 16:52:19 +0000 (UTC)
Message-ID: <08a97aac-6c77-451a-a2a5-20606bdde51f@schaufler-ca.com>
Date: Fri, 30 May 2025 09:52:17 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Paul Moore <paul@paul-moore.com>, sergeh@kernel.org,
 David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>,
 linux-security-module@vger.kernel.org,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 Peter Newman <peternewman@google.com>, Andy Lutomirski
 <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Jarkko Sakkinen <jarkko@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
References: <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net> <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net> <20250310.990b29c809af@gnoack.org>
 <20250311.aefai7vo6huW@digikod.net> <20250518.be040c48937c@gnoack.org>
 <20250518.xeevoom3kieY@digikod.net> <aDmvpOMlaAZOXrji@google.com>
 <20250530.ozeuZufee5yu@digikod.net> <aDncH8D9FoyAIsTv@google.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <aDncH8D9FoyAIsTv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23884 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/30/2025 9:26 AM, Günther Noack wrote:
> On Fri, May 30, 2025 at 05:11:34PM +0200, Mickaël Salaün wrote:
>> On Fri, May 30, 2025 at 03:16:20PM +0200, Günther Noack wrote:
>>> On Sun, May 18, 2025 at 09:57:32PM +0200, Mickaël Salaün wrote:
>>>> We should rename the flag to LANDLOCK_RESTRICT_SELF_PROCESS to make it
>>>> clear what it does.
>>>>
>>>> The remaining issues are still the potential memory allocation failures.
>>>> There are two things:
>>>>
>>>> 1. We should try as much as possible to limit useless credential
>>>>    duplications by not creating a new struct cred if parent credentials
>>>>    are the same.
>>>>
>>>> 2. To avoid the libpsx inconsistency (because of ENOMEM or EPERM),
>>>>    landlock_restrict_self(2) should handle memory allocation and
>>>>    transition the process from a known state to another known state.
>>>>
>>>> What about this approach:
>>>> - "Freeze" all threads of the current process (not ideal but simple) to
>>>>   make sure their credentials don't get updated.
>>>> - Create a new blank credential for the calling thread.
>>>> - Walk through all threads and create a new blank credential for all
>>>>   threads with a different cred than the caller.
>>>> - Inject a task work that will call cred_transfer() for all threads with
>>>>   either the same new credential used by the caller (incrementing the
>>>>   refcount), or it will populate and use a blank one if it has different
>>>>   credentials than the caller.
>>>>
>>>> This may not efficiently deduplicate credentials for all threads but it
>>>> is a simple deduplication approach that should be useful in most cases.
>>>>
>>>> The difficult part is mainly in the "fleezing". It would be nice to
>>>> change the cred API to avoid that but I'm not sure how.
>>> I don't see an option how we could freeze the credentials of other threads:
>>>
>>> To freeze a task's credentials, we would have to inhibit that commit_creds()
>>> succeeds on that task, and I don't see how that would be done - we can not
>>> prevent these tasks from calling commit_creds() [1], and when commit_creds()
>>> gets called, it is guaranteed to work.
>>>
>>> So in my mind, we have to somehow deal with the possibility that a task has a
>>> new and not-previously-seen struct creds, by the time that its task_work gets
>>> called.  As a consequence, I think a call to prepare_creds() would then be
>>> unavoidable in the task_work?
>> OK, we don't need to freeze all threads, just to block thread creation.
>>
>> What about that:
>> 1. lock thread creation for this process
>> 2. call prepare_creds() for the calling thread (called new_cred)
>> 3. call cred_alloc_blank() for all other threads, store them in a list,
>>    and exit if ENOMEM
>> 4. asynchronously walk through all threads, and for each:
>>   a. if its creds are the same (i.e. same pointer) as the calling
>>      thread's ones, then call get_cred(new_cred) and
>>      commit_creds(new_cred).
>>   b. otherwise, take a blank cred, call cred_transfer(), add the
>>      Landlock domain, and commit_creds() with it.
>> 5. free all unused blank creds (most)
>> 6. call commit_creds(new_creds) and return
>>
>> Pros:
>> - do not block threads
>> - minimize cred duplication
>> - atomic operation (from the point of view of the caller): all or
>>   nothing (with an error)
>> - almost no change to existing cred API
>>
>> Cons:
>> - block thread creation
>> - initially allocate one cred per thread (but free most of them after)
> The proposal is growing on me.
>
> One way to view transfer_creds() and have it nicely fit into the credentials API
> would be to view prepare_creds() as a convenience wrapper around
> transfer_creds(), so that prepare_creds() is implemented as a function which:
>
>   1) allocates a new struct cred (this may fail)
>   2) calls transfer_creds() with the new struct cred to populate
>
> We could then move the bulk of its existing prepare_creds() implementation into
> the new transfer_creds(), and could also move the keyctl implementation to use
> that.
>
> A remaining problem is: The caveat and the underlying assumption is that
> transfer_creds() must never fail when it runs in the task work, if we want to
> avoid the additional synchronization.  The existing cases in which the
> credentials preparation logic can return an error are:
>
> * Allocation failure for struct cred  (we would get rid of this)
> * get_ucounts(new->ucounts) returns NULL  (not supposed to happen, AFAICT)
> * security_prepare_creds() fails.  Existing LSM implementations are:
>   * Tomoyo, SELinux, AppArmor, Landlock: always return 0
>   * SMACK: May return -ENOMEM on allocation failure
>
>
> So summing up, in my understanding, the prerequisites for this approach are that:
>
>   1) get_ucounts() never returns NULL, and
>
>   2) SMACK does not bubble up allocation errors from the cred_prepare hook
>
>      Casey, Jarkko: do you think this is realistic for SMACK to change?

It's possible, but not trivial. The task based access rule list and relabel
list would need to move from the Smack cred blob to a Smack task blob. There
wasn't a task blob when these lists were introduced, so the cred was the only
option. I would entertain patches.

>
> and that
>
>   3) We can block new thread creation
>
>      Mickaël, do you have a specific approach in mind for that?
>
>      As Jann pointed out in [1], the tasklist_lock and siglock are not sleepable
>      and can't be used while waiting, which is why he proposed an approach where
>      we retry in a loop until no new threads show up any more, while getting the
>      existing threads stuck in the task_work as well (where they can't spawn new
>      threads).
>
>
> Thanks,
>
> —Günther
>
> [1] https://lore.kernel.org/all/CAG48ez0pWg3OTABfCKRk5sWrURM-HdJhQMcWedEppc_z1rrVJw@mail.gmail.com/
>
