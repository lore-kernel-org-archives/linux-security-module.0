Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFB3B8945
	for <linux-security-module@vger.kernel.org>; Thu,  7 May 2026 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155449; cv=none; b=qFPFspL6MvSvqv6o6KRmrN38f7vRuuPJdUqhj/PBDZ+yGVGN+mOmk7EKEs8NlGSFv4u+4SdMEzCaTKOzYJAxFKTIX1ahrws5O9DTvUAN5b7NHQftLd8YfE503kFSxYbzLEgREb24BjcJidOc3V+lCD90wXz2HVKzPJaMloas+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155449; c=relaxed/simple;
	bh=T8EtYFipGWvnMjMF+3tEvxPNBm0vfHz1WTDCFPpbNV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=szZivVQ5akFaUcc7+yofWzsqYgvDisRxJVdatyt/nkU+y9vcvfnY2GGRp/EF1vuMJnzrP45v+4i+OdxkKYdak74jpUegnGtQSQguvhIImHbx/y/1lX1Gamk72Tfg5aVoMWZp2FdRnR8lADMV3/XxWw7ymfvH2Ql6gIvtebXKtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MseMl9LM; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MseMl9LM"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6771df2b5easo690515a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2026 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778155441; x=1778760241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXDCzyYbe0fvDc+BkrtxvXQejJaBIAM1AIWN2IkCsvs=;
        b=MseMl9LM/9YVaq0qbUpCjMMWfuZRO5ktR2j9AGDU9hH2VC05nIYE1gSkzScR29I4LT
         guV5C7d6mVf55B1/c7zGMpALw31oP//jS4t8IhQCXQeQUM2ZTeAcKd5BTnkFF7nPHlzI
         DzDnF4vcKVXTiOzW5BJIQdJzkn2YtK//eUnpEjDx/ANIqVr+OZIoPnDs/43MbnUUqe8y
         IYrbDCbXHbQe6q9zOYHY46bhl0Jl0tD/K9/sdiOM32Fr6K5f9UlZuy57n9RDXyog/Qsj
         OFi5X63rnr/H46Rf1bXEwe0Q6KJgxNmImRl8i57xfms7JbCngXN3QlJiocKtRBIYSv0r
         j3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778155441; x=1778760241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXDCzyYbe0fvDc+BkrtxvXQejJaBIAM1AIWN2IkCsvs=;
        b=N3W11DtPYGJ5iEsU/qbmFox186iqz5kqSxnmAXncEz4MfltoL3DPBmUSQ9czuvt52v
         wy2l0z+Up8tylHBSyRqR4C0nwlQRe9VSa7n40Lk6vaSd2m6FrEViKG1mHo7UIUXO50TZ
         xnHFJdhVF3HR+a2ym9OnOINd0zz+k9PzjKkjMEnUBsYy60xI5mDXLGxR3B+PXSm/s7Mo
         kiQG3C7N0HvKxZCCv3/Q41U5wEsZm3GO9/TXooDuLLMRS6f/0Msk89Yrs930zsyslQ6a
         JsNy6lu9itCj8ZEzhE4tU7TUmev39aNtxI9GrEH+8uQm4KF2bF79xCZPxd6i7z8ja3UP
         C2Eg==
X-Forwarded-Encrypted: i=1; AFNElJ8VhsjNNKPurS0HLFOCQ2Jlzewp33BdwlCUAaLbai/eNpOUXs3wVP0ciW55tM86fXVoEIESiqhmPfe0noTDSfR5knU9R14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBujHMBwSXKcvCrAAy0JWBeHbStR7oGZk11sCYi6lH+w9bHHy
	xKpFK8boGEne5Hgl15QHR+Eb1yvfU+dl8dZ+hJcWjRjJwqZ9sXMXvoSZB6vllky+0S6rZj18dnn
	3sU3Kg0iQvbWPC3naaw==
X-Received: from edbh15.prod.google.com ([2002:a05:6402:50cf:b0:672:bfdb:8b72])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:eaa:b0:669:cc03:334a with SMTP id 4fb4d7f45d1cf-67d63d984d0mr3569787a12.11.1778155440181;
 Thu, 07 May 2026 05:04:00 -0700 (PDT)
Date: Thu, 7 May 2026 12:03:59 +0000
In-Reply-To: <DICEBGUAU4OT.244JDJIKXRHBS@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-remove-task-euid-v3-0-27f22f335c2c@google.com>
 <20260507-remove-task-euid-v3-1-27f22f335c2c@google.com> <DICEBGUAU4OT.244JDJIKXRHBS@garyguo.net>
Message-ID: <afx_rzB-NvW5JkoY@google.com>
Subject: Re: [PATCH v3 1/2] rust: task: clarify comments on task UID accessors
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, May 07, 2026 at 12:08:35PM +0100, Gary Guo wrote:
> On Thu May 7, 2026 at 10:48 AM BST, Alice Ryhl wrote:
> > -    /// Returns the UID of the given task.
> > +    /// Returns the objective real UID of the given task.
> >      #[inline]
> >      pub fn uid(&self) -> Kuid {
> >          // SAFETY: It's always safe to call `task_uid` on a valid task.
> >          Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
> >      }
> >  
> > -    /// Returns the effective UID of the given task.
> > +    /// Returns the objective effective UID of the given task.
> > +    ///
> > +    /// You should probably not be using this; the effective UID is normally
> > +    /// only relevant in subjective credentials.
> >      #[inline]
> >      pub fn euid(&self) -> Kuid {
> >          // SAFETY: It's always safe to call `task_euid` on a valid task.
> > @@ -371,7 +374,7 @@ fn eq(&self, other: &Self) -> bool {
> >  impl Eq for Task {}
> >  
> >  impl Kuid {
> > -    /// Get the current euid.
> > +    /// Get the current subjective euid.
> 
> For consistency this should be "subjective effective UID".

I can update this for the next version.

Alice
