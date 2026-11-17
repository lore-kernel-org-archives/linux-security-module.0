Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794937497;
	b=xn0RSCfYvkyS233qrvBnH0ZKJpRgtn+qdX6hZyrLMiu5uWJTHT87gNTuUE8Kvn1QMwzV
	 ZHQRIO0np+JjoN1znzRSpinBrufRrbWwFICpU8YI3hdyfiA44nfazNSZZVPwqylkpsM0K
	 Q1qA+yfc8poc6JuALHwCm6T2o5Gntg72l+mxrcii05z2RvEgwsEQqak5wOEQSAmHnZAI+
	 v4FYXqDbIqr2qPlgtvRMB4BIU6o2pTEfw5V08eHs68LYjn9VyFY/4xvcQ88ZjxGztJVZg
	 PjQWHi63GTSakPLf1wZitGB2caEX9ZQZA3YffsHMN8aU5qEZWGZKj+7qOoZ0v4yzWjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eNNOnQUc8HQHxzszI7I5Z5MCWmY2JGLCloKQuWJY2Z0=;
	b=zly9aqptApnDD5HQGmuDfYr++VdLbuJhhmWllQ/EtL9UeIShnet1p7CbbeQkccmFJoZI
	 kGl2uq0fu/46Um2lO7jJv5AIolY/aAWuxPP5z2ycrWwZBBKBOjyUsGIxZMfxf00/tWHXv
	 oL6qMbkpMkZmkUl1bN4Z/Co6PQA80hgVbGUq+fWlhwT5t9/+WH/LabeQA10F5PeELKJYX
	 k8fyoFaX2+ra1nOeE0ieqsIhlxdUqgtMOwafLAbiuFuStAXfwXKEH+bWwUCgIS6vorrrQ
	 9SMzigBSB+uAw3cm2WSg9+Z2svpC/tIRpSRfsQ+7B+vkLAnsKrgGwX4zsq/9+uyWvgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oAFIhfOA;
	arc=fail smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E54606A32F
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 17:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E54606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oAFIhfOA
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ae0d0b9db2so1488331fa.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 09:44:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937495; cv=none;
        d=google.com; s=arc-20260327;
        b=YycsAkCd5fLCQ8rw9EnUEzTCzGjXLQ69ULsSPtk2kxVMJzWpBgAZ/szMn6EtxtBJ0k
         YDlD5x8UzOVR0rBUh8R8E4DnHijQhoAmLsUTGAf8QsGuDRuY4jGazva1n97JCJsLusY5
         hHbJMZUdTGlLXt0enZAiPvdqsJt74xk0ALhGBv0BXxDcW648fPRnp87ce5WsntqPwAHD
         Hk9sU5GhLC97HS6krhP0JM2JzVDvT+2CbnA0PgbxuduLbtUjKjzySeUAZ9/w8bsN4jlu
         l0GkQzfFG/BRipDz43twM5Jh6BIQUkcreZHNA0SbvADoQyDG7TxbszHLudJuFcZ2+aOZ
         6qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eNNOnQUc8HQHxzszI7I5Z5MCWmY2JGLCloKQuWJY2Z0=;
        fh=rBGW5Ko2lj77mCMaWGfZ818v98PTUIoRq1ZeZTTCSDg=;
        b=d9vYTenTGfWqqBNhBIOj71MmU3yjbfAjetgvuScPBApPrzx7Ym1IpUL725nn428B/i
         XFHiEY+aCjbfw6piBg/d6GjQ7YdmXOQso6cbpWAnciK+VtEEv2QKLuUKQTiMWDygOsMb
         Sp644O1s9EdRkCHt5lqDDjek9ZlOeYbwzvZ1SHildmEjeok+GBlivqPfkksbQZDi1aLQ
         uDDiN/tH7pUcOta0zxRjId2VVxNtCxQ28OGDUp5VlbbFazsXbNbsMUaKqroEa69JuxT2
         VOVvoWMYokviBrTOVhuC1wemZVycj01inkM3288tNP7HEy9XI/1hK2enctY4Re7r7pKL
         pghw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794937495; x=1795542295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eNNOnQUc8HQHxzszI7I5Z5MCWmY2JGLCloKQuWJY2Z0=;
        b=oAFIhfOAkcB0Dg4mKVfkuis2uNtcfHHW1ME1slyaFUO4AI5iAHAmrY1Nw3LuN2VQnC
         6IGXyvAYklXrHuXDFIJP+OpIvCKpQXcsR6yhi7y7UMeoYZWd0Rkq8srCeIQr3Ut6yHo9
         s3QMrLw8d+7yQo0fv8lDR6N1UWY7BgFBjya/tZ7WAbd98chUjwhGKhZVz4B8CNKS2JVt
         s01yrFYXNsMtBbhpU0mHCjFVPEb/8RNf03yXDk0jC6t71dtVUAnUQlSNlv3yrv5kFy/Z
         7TcwXV5Nfa08sHn/NIrA4+u1dyH1Y1UL/1CiJgo3Ncba+UeXkhzzSc1rUH+9TFU6YyuR
         ZiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937495; x=1795542295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eNNOnQUc8HQHxzszI7I5Z5MCWmY2JGLCloKQuWJY2Z0=;
        b=ROSvUE7t8X6nNqxju5roj+cliEaWpOmNwKcdUry36htqLVdAWNXOxb36+FpGI0djRA
         gmvktw61xb8cOKr8Kbz0O+9T+JHq2SeEmMcWSybsjTFWKq9J4nQm3JYKmK27GQKsKLeG
         gXhU25AKMIOinACmsmG+7l9LFrJeex83T+8n84WS1oFe29DH8oBspEdA86F0kElLs5pw
         66f+5yzFMGlBqOImP0ucHl3gSTJmTpgeoE6MztF5urW+eFMjK186ApHQYixXgTBu0XLY
         6c4RaTWQZCFmi5rWA5jHkobdJ/NwU8iehRWXaRLi710L4IP6o/1dyyKn7cksZXrxG0Fo
         AzoA==
X-Forwarded-Encrypted: i=1; AL+hErGZpEhEp1dPqbpJ3HVXzqJ3q6Npryo6r/qHJq6t3SFrTjciLOq3JBzsIVLKXqHFAsh16xXXonYZHigpywB1BR4pu31x4YQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TBEbB/g50QvbvEEhSdlQCgufEQRWM8G+NqriZ2F+QUXqmLSxR
	rdHp/hMAJbAnlo2WSsn6Q5KVD5ySjPCkkMNDppZUxypezTrCpr7fVpKISJBo5VfIlQsol3ZzVQA
	icW7qjZQ+rIUmA0o3gTwCfdNMpyazPsQYvsCgZdCN
X-Gm-Gg: AYBFou30uh4X4arUUaqjnJs9616zDcP7KYVaNLCQEjRtPOKx69AWQYJeT/sN7szkURk
	Hzw3MJtc9dVL2yOOkUGWDglDNj+oxVb2jvLni1BOVK2U8eG86OIpDZrvyDY1hcpN113vuiMJZiG
	vHHRtAGfSvCKmi6obqSxGXVK0wVOU1RDQRh7E59DpbRLjFKsjrikOyIl0faLKX9IkDaZ/tzziDi
	Z68XegyQIWifxRxCdAiAwNR8p8z72VLaHMOCSaEwMurGfZZSS4uW1CvsVYTLkQiNCY09+FkPd99
	LSoA11cagE/BbVvqIXdOzspiiaTU7QH4ILwOGqkDuHdOKIFIL9NTfr9AnMVUGdJ3NMB7p6oyP8g
	0AvKYTOOLdQDxCdrOJGQEEC/4bGs8GlvIiIS+wvCgTO+M9/L+rSznNjo=
X-Received: by 2002:ac2:51c6:0:b0:5bf:b945:4334 with SMTP id
 2adb3069b0e04-5c170a15b78mr6210350e87.67.1794937495491; Tue, 17 Nov 2026
 09:44:55 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117050841.3289652-1-jarkko@kernel.org>
In-Reply-To: <20261117050841.3289652-1-jarkko@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 17 Nov 2026 09:44:43 -0800
X-Gm-Features: Aa3M54pzaE332pTi53D1YpA5VO7WahNUrZvzEHccu8lFNhASVJD5SKW-Zdzq05g
Message-ID: <CALCETrUBUnJVhiMkft6hTZZMe8nTpMBRTGY2v=9x5ETBSvmPZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Namespace for namespace roots
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:08=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> OVERVIEW
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> The problem that root namespaces try to resolve is starting a container
> from a root mount tree that is pre-populated before any process is allowe=
d
> to run, without inheriting any host mount-tree ancestors.
>
> Work on this feature started originally in 2025 from David Howells'
> container object patch set [1], but I turned container objects into a
> namespace of namespace roots and built a new implementation around this
> premise.
>
> In early 2026, the patch set was left to gather dust in my kernel tree
> [2]. Then, the other day I saw [3] as was shocked by its over the top
> complexity and thus, here we are.
>
> Not doubling the number of container frameworks inside Linux kernel is at
> least a benefit over container object based solutions. Parallel plumbing =
is
> an inherent flaw of container objects, and it directly affects on
> development and maintenance cost of container runtimes.
>
> Also, thanks to better scoped implementation surface, verifying rootns
> correctness is factors easier than with container objects, and even my
> early kselftest is meaningful. We know what and where we are testing,
> which is always great.
>
> Finally, it is more compatible with pre-existing container tooling
> whereas container objects would have much higher cost.
>
> [1] https://lore.kernel.org/all/155059610368.17079.2220554006494174417.st=
git@warthog.procyon.org.uk/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.gi=
t/log/?h=3Drootns
> [3] https://lore.kernel.org/linux-fsdevel/20261105-b4-cells-v3-0-bc909593=
7a84@toxicpanda.com/
>
> IMPLEMENTATION
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> rootns_create() allocates a rootns object backed by a pollable anonymous
> inode fd, pinning dedicated empty mount (CLONE_EMPTY_MNTNS) and PID
> namespaces along with any optional namespaces selected in flags.
>
> Before entry, a manager prepares the mount tree through the control fd:
> FSCONFIG_SET_ROOTNS binds a newly opened fs_context to the target rootns,
> and move_mount(..., MOVE_MOUNT_T_ROOTNS_ROOT) installs "/" onto the nullf=
s
> root once and attaches relative submounts beneath it.
>
> rootns_enter() forks a child directly into the rootns credentials,
> nsproxy, and root path without mutating the caller in place. The first
> entrant becomes PID 1; once it exits and zap_pid_ns_processes() reaps all
> members, poll() reports EPOLLHUP and rootns_wait() returns init's status
> and rusage. rootns_kill() walks pid_ns->idr under RCU to signal member
> thread groups.

Can you clarify what this new API actually does?  I've read this three
times, and the best understanding I've come up with is that you've
designed a way to create a group of namespaces identified by an fd and
you're adding an API to configure and enter them cleanly.  Which
sounds very sensible.  But I'm completely confused as to why a
namespace needs to be owned by a "rootns" or why that ownership
affects even newly created sub-namespaces.

--Andy
--=20
Andy Lutomirski
AMA Capital Management, LLC
