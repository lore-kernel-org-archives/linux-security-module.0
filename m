Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031349365A
	for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2026 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523715; cv=none; b=FPqvtlOCp/UMOAJWn6KQmi5Kkb5PTEbaqtIX+YEG1mW5CeADL+zi8hqbdjtkNyNOYT+XSRCTQR+QgYXKqZxRgkUrjs458bNiw5Dx7FDAlAhimCL88A7QPf35x7exonACNShp6E3Brns8AcBvGkWCKVLXuIea/bu+FvTxEhspmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523715; c=relaxed/simple;
	bh=v0HEBdxKtJ2VIoIBcO+LV65ae5qprVDBxa266sxfAeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkebD7XeawktPyutGE9592L52n8ocqgC94tFL9kgSo5ewTZIgICFwaVXeeXmIftdajpadZu1B9Be0ZZ1EL4YiYcknTWJjaddHDWnPzWcN1Gs3lUEDWHyzqctIrAZfnBXPbSwN+f2M6nwGRjE42oKibE7kSRuofnKmQnNcDESQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR78KMP3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR78KMP3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so5253246a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2026 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787523712; x=1788128512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HiVBuuT58QsDxEPMvDJSa+VRRE6go33PUf1R1Lclf2A=;
        b=XR78KMP3OyN+FYzkHhmazC2RQSXVCEieEMezJ8B4OUydTk9uaLhEP2zYo4VrB8TGgh
         gbbF9v3AHRm2kUMs4f+KoB+kH01NXuTfS0UMuiXFe6/+N3geWg1ZESSZB6g3Vsb0CgkG
         JLBe4/SH9YHWkXztlHDh53k5+W9+w8feU9pi7qbBcjFr4uGuWLJUf7H3jBBSFKLcFkGX
         T7JzlRa7fGaD6atYZ3RAQdl8mf6BiEBPl2FdYjLnC8Gw5E5zSvY57AFpUNwCKfGqE+IE
         IJ3L++seVXRVZvFp1sS/kSXevcK6qnCgDlmmTxoin5OEokcnGSyAtIq8fJpw0krP0Ufa
         x9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787523712; x=1788128512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HiVBuuT58QsDxEPMvDJSa+VRRE6go33PUf1R1Lclf2A=;
        b=lGiQzFuxbcIzd3bDHqokTtf3MpxV44UPhjBI5nfKrs/D0jv93kMhmlTO4W5ATRgiCn
         edUvPjG45qDL/D25RXmUmoZGxRvZ3cnojnpZbSuHZx7eRlGyEYmgxuxpCZWjluCGgoFS
         0zw7nlxBJjrKZCkhpNQc9I2XCqGn5HKiqmPD+8LyWf93C5CZW9sZOubD94JvbcEw4VWS
         IwVRH2TanxDz1yHFHwiDJbJQIv41f5sMYxZgLetFZWV1vMxUeLVtsXXMAUAsl5hNGMRy
         hr7nY95DsYaRALW1YWpMVgUeRVcQvMMU/SfTzqlvsxgFhICNW5bM5poWeG3L+Kl14FNG
         +O5g==
X-Forwarded-Encrypted: i=1; AHgh+RrANtA/u2eeEfC3v+WGvbTrD/ue5Gq1ygdDCIHj4teuMtlcKsJzBX5XKmM/u/2rMhqyTc4FYIgACge6co5pukD9VP/Q1gA=@vger.kernel.org
X-Gm-Message-State: AFuF++k3JxTUv5YWxN1+wAyNT0boIX5i1e7t33O0u1YzBwlQW+wjrJRM
	d14EdG5LkPxn4VdimYesk+1Uc3YPrV/LtiNkRu1uBIS+PxjuMb4fzFxi
X-Gm-Gg: AR+sD10sXlWLlR34fA3xa62fW1dkVVmki7gLToqMALxxASf2uftV8VNkhXozuFE/e8i
	7vdC7SfzizJ0fhpasxmX7jj8DfIOwohQnidGAZUmPqNZSfFDcCH+GZRC6MEphboD8zvaq6p+os3
	jC6pZrmLAh2XU7KV8QV1kbiAWO2kEPa9Fu0w/YIHENnL9g4q7R7DwkPGCYfFVcsE4Zolj9/DZqW
	axjDSxcNZpZp+k3CceaAkYQ3HpNmj1jUQELPHzvOrwlMxHUrjd8ElcgNJUny1rDVhAdJbcaUI2R
	s8aMjt89sJSuBlbvSQf8yX0eNt8KXxlgbvnEr/DC67iHoy5vDG0Gpbr9FFci1BO94rVxcEU1P9+
	gC/wzOzKSHs/KQzBiv1fppTfRcqDkCPMH/xRb1Ok+xOjEzh2Jwkbj1zcO1PNsz5LQQ1Gpy0Vbyw
	uK9o8lHIWWgtYEwUMxohbJKTnmtYgjVhIQeaEK9f9RO3l7m/XROn9z62r/CCFCJxV64U4gOkbu0
	YoLffca2BSy2A==
X-Received: by 2002:a17:906:9c93:b0:c24:6687:bf6a with SMTP id a640c23a62f3a-c2492663ee3mr1486153166b.21.1787523711762;
        Sun, 23 Aug 2026 15:21:51 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296aa0sm998422766b.19.2026.08.23.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 15:21:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 00:21:46 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] landlock: Add scoped access bit for SysV message
 queues
Message-ID: <20260823.27c95ac14b81@gnoack.org>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260822.c9dcabf4999f@gnoack.org>
 <20260822.3340c3dd2a46@gnoack.org>
 <aooS2VVhwWjY7ugo@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aooS2VVhwWjY7ugo@zenbox>

On Sat, Aug 22, 2026 at 05:51:33PM -0400, Justin Suess wrote:
> On Sat, Aug 22, 2026 at 11:13:44PM +0200, Günther Noack wrote:
> > On Sat, Aug 22, 2026 at 07:26:33PM +0200, Günther Noack wrote:
> > > I get the impression that with this scheme it would be possible for a
> > > landlocked process to guess the key of a set of programs which have
> > > not created their message queue yet, so that these would then start
> > > communicating on that message queue which the sandboxed process has
> > > access to.
> > 
> > I realized I did maybe not express that clearly enough: Not only would
> > the landlocked process guess the right key, but it would then also
> > *create* the queue msgget(key, IPC_CREAT|mode).
> > 
> > There apparently is a pattern in real-world software where the program
> > creates the message queue on the fly if it doesn't exist yet, but uses
> > the existing queue if it does.  Such software is then prone to reuse
> > the message queue that was created by the landlocked process.  (You
> > can find such programs using the Debian code search query from the
> > parent mail.)
> > 
> > Step 1: Landlocked program creates message queue.
> >         Because it creates the queue, it has access to it.
> > 
> > Step 2: Program outside of that domain runs, trying to use the message
> >         queue.  It discovers that the queue already exists and starts
> >         using it.
> > 
> > Step 3: Landlocked program can read and write the queue and manipulate
> >         it.
> > 
> I do agree. It's a little harder than unix sockets where we can control
> things at the client/server level (no such construct exists for sysv)
> 
> It's a little bit tricky. I suppose the easiest way to handle it would
> be to deny the ability to squat in a key in the first place. (deny msgget
> except with IPC_PRIVATE).
> 
> This comes with a cost in functionality, but it is easy to implement and
> closes the gap.

Hm, I have to ponder this; to paraphrase and collect some thoughts:

1. that would make all named (keyed) message queues unreachable,
   because they can only be created outside of a Landlock domain.
2. the ones created with IPC_PRIVATE within the same domain are
   still usable.

I find it hard to construct a realistic scenario in which any
communication would still happen across scope boundaries in that case.

It comes at the expense of not being able to create named (keyed)
message queues within a Landlock domain, which would be potentially
surprising, but I also don't currently see a better way.

(With low confidence): I do wonder whether a landlocked process should
be able to lift that queue-creation restriction if it does it within
an IPC namespace that was created within that Landlock domain?  (It
would complicate the implementation further, and the namespace
interaction would be unusual for a "scoped" access right. Not sure
whether it's worth it.)

It is still possible to guess the msqids within the same IPC
namespace, but the system calls that take a msqid argument will only
work with the ones that were created in the same domain.

Passing a reference to a IPC_PRIVATE queue outwards of a Landlock
domain is possible (e.g. by telling the msgqid number to that process
somehow), and that can establish a communication channel.  This seems
like an unusual way to set that up, but it would be acceptable,
because the outside process would need to collaborate to set it up.
This is in my understanding the only way to establish a cross-scope
communication using a message queue, in your proposal?

Apologies for the brain dump here; I have not fully convinced myself,
but would be interested to hear what you think or whether that seems
correct.

Thanks,
–Günther
