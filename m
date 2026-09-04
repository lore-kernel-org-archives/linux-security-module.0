Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA81509EEA
	for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541267; cv=none; b=SZka6ymYyZyt9zrxdy39bny5Mh9CYhavnUbUzp0hAn5Oj7D19znfDhZfKeYMD1BdR21qNZxpZBTE8XZQkQj9dn4dt8glV9yfua6HryonIdL8TjvChmFLcO5GV/MR0mBaKJPVjlnWgxk/d/RHOB6gGe55ma4RDLTWK7h2EaAr7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541267; c=relaxed/simple;
	bh=ZdzwbYcSxFp1YM2NzyKteD8bxTtEzteMVXqKaxQGfHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nl+mwbHqY2/4UO4zTPapNadVbk/NijQZpytDx4i5c0z7PTFydv3m1StwZMDi2zYReOf+ssIB0WQbgV23/ifRWTxyOu6DehX7CQiLdDLzDNJM/sCKZeV/AxmVWzyXKGOUYfarSeFhci09SSqHljMPdUaSSDFBcZj6XoHmNGXX2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c25fbcf5d44so190956266b.1
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2026 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541264; x=1789146064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GyJwn4+ssjywZb/F3JjOY0S6/aIo0tP90S69DFDLuSQ=;
        b=lsnzKwN8nUWeVOYo+NAPLrCs+bZfE/+Ml7hw1d2mSUvCjRjIY1KnAts73f91uKj8oY
         nXKYlRpnusgSriUTEaogYzpBAyzC69gRvTXiw+YOV0OtHCZs82dKTfVjY0E09CTXmWC4
         s2lkSZGNt8FJ91F6C/TjzdejR55AG4Xthd0R5v59zu8Vii0F7AsdR6aiO+AkRbzBfzit
         hIwiDtznf8sEBL9W3v8PbAt8/HwXISVirtGw/hKlrqRx7iD4+hCT8ymGAioJpZHLx/Qd
         tSX2g48cpx8LelRooLMlszdMp6J4GnprSG7Zfv+c+TRiYuH7fU4KjLZ9jdE5HxnWOZrK
         947w==
X-Forwarded-Encrypted: i=1; AKwUvBzH4Rh9m0eHbjlhLwpFV77IIL+yQJZ6grByMevoOQZCn9hnoSIeTomE2cVhPKzvafrH/mTjxkWeHuanGnGkvE+5nbd1Wy8=@vger.kernel.org
X-Gm-Message-State: AFuF++lz9hxAwEWecWqmdPyXDfA7kYISRsCMIhZdTpQNqkfkCp7wqmwX
	N0rO47S/Kew1hnd0Gvx4ZCCj8z3tJmzilXobxGEm/nZKjRI+cnRs6sRH0zAtUHiKnGmLBjgf
X-Gm-Gg: AYBFou2CQcM++R7a2FIXWRW/bvSmWSmR/4cMTi9OH8bIqOSSPFv3teovx1MlEj3PIDv
	lysHNYb3m67Nd7174wYQPUBQdXwAE2/oAXCoHAt4fVQS2QN1gWmcw0yf7nLO5xjhEZdwn88Jzy+
	EGX6oaEJneOpICZy4ecZa1hANXoc1+b1Mo+KNxJ8zLSztJ3QkHwHGEEBR3a6u0iFcpKJLSsHLdv
	IBNXi32HgXQgBzGNGhdvtkkXcaxjF5l1X3DHrAZE9kt+vkAGIWB1Q5AVy0hXqepAgg91Hekmama
	8lnO3KwWIVFMLQZS3AJUng1twIh4zHEaUm8r27MGc4B29cK9Og1f/92wQfd5VDDmu1DxT68vTwN
	6feBXChhSUw5IPGgFXBqJZ+Kfwzphxp+lFgBxefL4rTPCIsnrYfJzP6RdekEGNdaHZyWoHPntop
	xobzakQElcfPSa3iEWY2ZIGiyejcCd8ilGBO1Tb7x55UbyXQMANsDXy73dq+VfVUxExw2KGO3yM
	4uBFImVFgn9SpfUSfXjtl2ia4zO7c4YkmRrJb/6h1+Lx3S5HjT6
X-Received: by 2002:a17:907:9709:b0:c26:2a5:819 with SMTP id a640c23a62f3a-c260ca1f474mr498227066b.18.1788541263751;
        Fri, 04 Sep 2026 10:01:03 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5ace84sm137757166b.49.2026.09.04.10.01.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 10:01:03 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-485843aeab8so1304187f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2026 10:01:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw65PXbToNHMCLzOf5SaiKK4txXXsNzTSrHcgVRV1Pqowde/9ItmmfpPkOYDlh05yajRFBOCjfsyx97Aopl5d7cjQ1PtlU=@vger.kernel.org
X-Received: by 2002:a05:6512:3502:b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b616ed4b1dmr2357411e87.6.1788540878064; Fri, 04 Sep 2026
 09:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn> <lhuecf9cbl8.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuecf9cbl8.fsf@oldenburg.str.redhat.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Sat, 5 Sep 2026 00:54:26 +0800
X-Gmail-Original-Message-ID: <CAC1kPDPu41RxMLHpPtz4VqfkEZeu-fYXG76XVZMh8bbQa3okaw@mail.gmail.com>
X-Gm-Features: AcwNN1UgBltmpHY5GDpzTdve1vmhfclnbN_NvQgKzWwvr0zbygpAGe7Eg-teU9E
Message-ID: <CAC1kPDPu41RxMLHpPtz4VqfkEZeu-fYXG76XVZMh8bbQa3okaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Florian Weimer <fweimer@redhat.com>
Cc: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, me@black-desk.cn, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:53=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Chen Linxuan via:
>
> > This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT. Each
> > ioctl takes no argument and returns a close-on-exec O_PATH file
> > descriptor referencing the corresponding task path.  The new ioctls use
> > the same ptrace permission check and nonzero-argument rejection as the
> > existing pidfd namespace ioctls.
>
> How would one upgrade the O_PATH descriptor to a full descriptor without
> a mounted /proc?

For PIDFD_GET_CWD and PIDFD_GET_ROOT, the returned O_PATH descriptor is
typically used directly as a base directory for openat(2) or passed to
fchdir(2), so upgrading it to a full descriptor is usually unnecessary.

For cases where upgrading an O_PATH descriptor to a full descriptor is
required without /proc mounted (such as inspecting the executable binary
from PIDFD_GET_EXE), users can use the newly added O_EMPTYPATH flag with
openat2(2) (introduced in Linux 7.2) to reopen the O_PATH descriptor.

>
> Thanks,
> Florian
>
>
