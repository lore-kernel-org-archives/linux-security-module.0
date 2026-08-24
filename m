Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A344071E3
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575652; cv=none; b=ot50x4o3T3uMtKVjQ7iNxA+EVtPIZlqTZzyHJy7gD+IxrIDCptrUnesywu7+Vbl2gX9Ebb54hvqn7k7nvYJvgwHS3p97mk/SIkR5hGHyWMjtMMbWv4pnQWcto9jo5jwnoKPm2uBBfLINt1Y6fpurHJrgMYxG8OYnwRntt2Oq5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575652; c=relaxed/simple;
	bh=La3U2CICLg4guNXdIK8UIu4P/3R3e4SprrA8tGEZGs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXUI1TbaxTNJh/9szkXc5l/LTlXpl6Am84Xh31fxc5+2ftaSc12es1u38h6a6LXo3/UT4VWAc9uqHdsWRmWq9/PknbN4Nm7LsF40M05xYkJLnaAsIquKSr0c8CLsHDaDF8tKTWubDFPFpzbc08XcGVmvJC15FMNywt3JtG1BDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j55A7Any; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j55A7Any"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8111c0c7561so50735107b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787575649; x=1788180449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXwlImfTiL6KkDeFlr4cjjV2OOHXS2U2CoZIXaLjK2o=;
        b=j55A7AnyCkrieW25tmcAeyt2sGbliLttqXcjrOHDHfMd8xVfPGtY6Y2SFs30DKbJ+v
         40wDUX+WFjDY2ritNQSSV3WZzYQkhdxjMeJApIdsbwwrGyVL4y2fie6BiPFpTx8arqlM
         6hw95Qzvt7OXKWIlCPLVViUyxBb6G0ocX2lL6qAcqTp59CaXJ3/X45T0kaN3m9WV7wTT
         ERaqyLoT/ukBVMPi9JCG0tHNTIMS5ZJC0uqNKMV/rBw/LCHlr1sssGwqWTAoBFaiCfyD
         PnWf99bYxLwWbK9GpcTpRHhiSsBPFkKnFio6blu/m/XI4Whqrej/RaUBMzkrSStpN2JJ
         WXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575649; x=1788180449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wXwlImfTiL6KkDeFlr4cjjV2OOHXS2U2CoZIXaLjK2o=;
        b=q0nVkUFQ0nH6zsm8o1u0OltXkAQBaOjwJwQZxAMb52/GcsG336z58Il3GKJ05VYlbN
         v6ooyEEHm2YZnjJ70cSOlZEkhDdR8oUnGEPqxLePtno7q/qkmaOz4rHnqV5JrGoWnQZf
         /CGOH5dRjyYsy/OwYmcSlF67W6Ah0Xsj9ZSFn6iwCKcnvjOUtHTj6sUlc5UyRHrXPpb2
         slomuo5k3+baAvml5HNgbuG2vlrwxaglaB24GpZr4E2KcYFC+1o0YzYeam9JvxMoDjTY
         Ul1wTe4wWLQ45KREM5NCD41qs9vLhwtdqTo1arZ8A7tpU1SY2ud6gaIxk9LZiSBNps+1
         jG0A==
X-Forwarded-Encrypted: i=1; AHgh+Rr9YCKJGJuT8ytCvW8vdtuU4xSJ4MbVdvtNzPINF3UXOKKabn61+ukh5HltZ6tAtiMa8psrhuBy9WeGWMnYrOf2P0FwlqY=@vger.kernel.org
X-Gm-Message-State: AFuF++kdfIiKi34tACbUYK5dVxcKKdi7og7IVoqEDdzx9NoflR+++Ik6
	fqe44cVrnwsQkQ/rKhnKxS4crByCSRuV/dY5eT4Vd2J2NP64DBqHMuy+b/D+fFeL
X-Gm-Gg: AR+sD12IiSa8OAlWJUdUnPctxq36K8nyY4emrMDadUX3ggGo//eHEZXqN9oPr0yFPz0
	cLOzHxug3rvIsvxjM9PsBlVp89/TC9Vq5mHuAKz5aX1bebXAquRFWuBhKBNL/xjrWztx66ZQ93u
	7cv1T5xhx4b9Ld+jn0AehPgmITNs4oStYZ+HbN8oqbwjRwo1exGw0zChj0OVVrzW3yRU2fwhySD
	dXAqv6jbBMeH4UMcce/GBoDvGEVuN6leUMYQ5XsR+JwzXHfeQWJCIX6bHlxIsH8iHjd99uRNm5p
	2BwA8RxNbeJvLUihTcu6cWSlek1NxKvVv1+oxUTC0NdD1MwcDJtifXA/2ok3ITTyanm2lAddAGB
	2klc43RBbfWv8wkxTc0W5sDfC0cg0RaK6I1+1aHwcxez3XP1kOfQWSO0Gtzg8ItAY45VK2uXIrE
	LnHqY3kXtP27CXK/Ytu1Peji3KJiZTy7CvKQhoOWDyeYl4gqscCxd3/cauUTWXEpY4DqgjBhv9W
	UV63qhFuIGuyJncGVbop/CZ
X-Received: by 2002:a05:690c:e197:10b0:81d:472c:17a8 with SMTP id 00721157ae682-849ea017381mr75679757b3.0.1787575649444;
        Mon, 24 Aug 2026 05:47:29 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:a0b8:e4ca:f643:3396])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5188f1dsm32561057b3.6.2026.08.24.05.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:47:28 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:47:28 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] landlock: Add scoped access bit for SysV message
 queues
Message-ID: <aow07i8dFO6EAB-K@zenbox>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260822.c9dcabf4999f@gnoack.org>
 <20260822.3340c3dd2a46@gnoack.org>
 <aooS2VVhwWjY7ugo@zenbox>
 <20260824.abc934a59c55@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824.abc934a59c55@gnoack.org>

On Mon, Aug 24, 2026 at 08:36:10AM +0200, Günther Noack wrote:
> On Sat, Aug 22, 2026 at 05:51:33PM -0400, Justin Suess wrote:
> > On Sat, Aug 22, 2026 at 11:13:44PM +0200, Günther Noack wrote:
> > > On Sat, Aug 22, 2026 at 07:26:33PM +0200, Günther Noack wrote:
> > > > I get the impression that with this scheme it would be possible for a
> > > > landlocked process to guess the key of a set of programs which have
> > > > not created their message queue yet, so that these would then start
> > > > communicating on that message queue which the sandboxed process has
> > > > access to.
> > > 
> > > I realized I did maybe not express that clearly enough: Not only would
> > > the landlocked process guess the right key, but it would then also
> > > *create* the queue msgget(key, IPC_CREAT|mode).
> > > 
> > > There apparently is a pattern in real-world software where the program
> > > creates the message queue on the fly if it doesn't exist yet, but uses
> > > the existing queue if it does.  Such software is then prone to reuse
> > > the message queue that was created by the landlocked process.  (You
> > > can find such programs using the Debian code search query from the
> > > parent mail.)
> > > 
> > > Step 1: Landlocked program creates message queue.
> > >         Because it creates the queue, it has access to it.
> > > 
> > > Step 2: Program outside of that domain runs, trying to use the message
> > >         queue.  It discovers that the queue already exists and starts
> > >         using it.
> > > 
> > > Step 3: Landlocked program can read and write the queue and manipulate
> > >         it.
> > > 
> > I do agree. It's a little harder than unix sockets where we can control
> > things at the client/server level (no such construct exists for sysv)
> > 
> > It's a little bit tricky. I suppose the easiest way to handle it would
> > be to deny the ability to squat in a key in the first place. (deny msgget
> > except with IPC_PRIVATE).
> > 
> > This comes with a cost in functionality, but it is easy to implement and
> > closes the gap.
> 
> Agreed.  I am personally leaning on the side of closing the gap as
> well, even if it reduces functionality somewhat.  SystemV Message
> Queues are used very seldomly (as can be seen in Debian Code Search)
> and it would affect few programs.
>
From msgget(2):

       A new message queue is created if key has the value IPC_PRIVATE or
       key isn't IPC_PRIVATE, no message queue with the given key key
       exists, and IPC_CREAT is specified in msgflg.

So more specifically, we will disallow if all three of these are true:

- IPC_CREAT is specified
- IPC_PRIVATE is not specified.
- The queue referenced by key does not already exist

Or if these two are true:

- The queue referenced by key already exists.
- The queue referenced by the key is not part of the scope.

Effectively, this allows as much as possible, including msgget(2) on an
existing queue within a scope.

> Possible Allow-listing variant
> ------------------------------
> 
> Another possibility that occurred to me after writing the last mail:
> One option we could also take here might be to *combine* the scoped
> approach and a allow-listing approach, as we have also done it for
> named Unix sockets.
> 
> In this case that could mean that you would be able to allow-list a
> *key*, and then for a msgsnd/msgrcv/msgctl queue operation to be
> allowed, it would require that either of these two conditions is
> fulfilled:
> 
> 1. The queue was created in the same Landlock scope (only for IPC_PRIVATE), OR
> 2. The queue is associated with an allow-listed key
> 
> Condition 2 is easy to check because the kernel already tracks the
> queue<->key association in struct kern_ipc_perm.
> 
> Advantages and Disadvantages:
> 
> * It would permit to connect outwards of the scope for allow-listed keys,
>   but only within the limits of what the sandbox policy permits.
> 
> * For keys generated on the fly as with ftok(), these keys are hard to
>   predict up front. (Would have to enforce the policy *after*
>   calculating ftok().)
> 
I'll keep this out of the scope for now, but it may be a possible
extension in the future, if a convinving usecase exists.

Each access grant could be an (SYSV_IPC_TYPE, key) tuple that implies
the relevant scope byte.

> ---
> 
> Given the limited number of programs that use SystemV message queues
> at all, I am unsure whether it is needed to implement that.  But maybe
I think that once there are scoped rights for all of the SysV IPC, that
can be examined.

SysV MQ is the oddball one nobody uses. SysV semaphores and shm are much
more popular. But it's important we make all of the SysV IPC rights
consistent with both eachother and the other scoped access rights.

Justin
> it would be an interesting thing to keep in mind so that we keep such
> an option open in the implementation?  It would at least not rule out
> the possibility of restricting SysV message queues in a finer-grained
> way.
> 
> Let me know what you think.
>
> –Günther
