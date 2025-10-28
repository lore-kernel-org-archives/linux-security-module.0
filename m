Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E5241691
	for <linux-security-module@vger.kernel.org>; Tue, 28 Oct 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641689; cv=none; b=a9+sP3jbR91ljZazj7+rNH7fh7vRh77f6MuNP++fFiWWe7f9VO5qEsHRML89j30/rsSKRJLq6JkFCfLQ5FDEi46jOIot4lhzEzAUhX/joHow6VbeSOIbWiK6R/Y0oCAwQqGV2FYSP9fGr+oc57w1hM0P7MylIMwCko8Dz+PBl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641689; c=relaxed/simple;
	bh=QeYx/eFxq6lR4+YZ/DP4VSYkYOnQaUkr9HNt8KAt9V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtMpAmnEA4EVprau0yawIkj49+2iFLSvsIakBqog1Gz4KeOiAJjz4ue3xu4A6wEAlkV+EKgqurOj35HakOkHtqOWhBFRTvrJFBLIvgRdi++ToKh0ejgn5QiuZeLSdz49C/FLIo8NKFq1rToR+LX5VdEsbGdw/ErMnX6rwnGiTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFjti9dY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFjti9dY"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso2942285a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 28 Oct 2025 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761641686; x=1762246486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zzTgGU8Fc6YeRB9n5ReEGGKnPVnwGcFzwEAmeAoo+6o=;
        b=zFjti9dYn8J4QTHiGtAwOeL3CC2dHxTOYfHv2mGg16qOaBgpifgevyxjJ9qLffs/Bg
         Y6s9EcXQvSIwCbpoA74vD+11teZ4P7G8wHUzx+2Ev4Po6xjcrs/4ErY1qV+tjJ9Gj/cG
         G4PKWLQU+aKQ3PD2CS/HYXP2XtlJEscOg31kXiPCT1YDCBBJKwNxrPAJQ5rKvZfBiqgR
         xjXrNg6334IkzeQd+fXVOKg1LA3jTrRqRONMoeOhn+0WdRLEWbFO125kaHW0dyht75II
         cWpezezAJxWAP79XOxPszpmw5nFbWjjmkaUy/g/g4zc5olxRLyPcsEnzN/NqwtO11Psw
         ygMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761641686; x=1762246486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzTgGU8Fc6YeRB9n5ReEGGKnPVnwGcFzwEAmeAoo+6o=;
        b=XFimfT7QPDSy0P1Zv1Aj/ssJqBwIlyrrV6zRzArOTHQR4Blt4pYv+XSskhntNo6/3S
         E0NlEOg7zuVP9XwE6UbMoFDZEOjuKJ1CjdzuSdIfKVSw80z2vujSFoEUvAUDQVjvRodR
         Ay0P6gQMnO8HAZMcVPBFbFRwubrpM4p+F2o62eO0qCbhOPzBFS23X3ZtdQ4en3upcPY3
         gjrsMdBxtgB/BizL2vtQOBM8kyxqOsV+U//H0KSrqB1O3XS3gJPALg6MKypuWy+jGGCL
         GNiC8yIJJrTsNiNK4PbF7YX4Ua/72jpWC8S96fNY7jqc62hFDP4AFf1mePKzt1mE4oGX
         kySg==
X-Forwarded-Encrypted: i=1; AJvYcCW7/mgMpnnqyhelfat8T4vqtPZbTyo4Pd31iHPI9BXq4k2BcaIhBUvvHiFDd6RxNxOXvLwZGAvYrV4nRPqsmB7Qw82OYAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8MXTLQaAyXecziBYOhHZEWYCUEaURtJEeEvnjKw935qXsaW0
	QOLgbojyuEf1F6t5J7OwUQxRXR0jYuVqOXRhSIoAiY8hgUuqQZHFwXAxOAiZaAvOMw==
X-Gm-Gg: ASbGncs8NaUfwwhqn2IF5RRdGRA/UxTAzHuBRtjsYcxKhJEqO4cmMw9S5Mloi/rg13J
	O2kXDDytP5XZw/S6qjseXpCQ1m0QdqnQRDuL9Imvw+TLDM33qFlJ3m96Lb5h7LmzlX0MCQ4b3XA
	q5LKpVHtEWWy0yJcfez5aQdnu9RFnX93r3AHk3BNn/YJO9sNF8BNX8T2G4K+Z0LAx67x3eJoPDw
	x1nKs8lLs0d7h/OcqdlCsJug2t68GW4yM+NKtGKHcB6B2Xf9t9sGX43In87MYWpqT3TZA0FSjDO
	mcYwiql/d3sUg7mEQIXuMiPCqmGDL90kdLMsFtx9zPVm1G+2RccMx/7kmZ+v55jziavx/ApAJq0
	DeEtGBmRg3Erhcn/jEabVtWh5Ygx4qKN38qIDxvzdmUfzevAxKljN0jxkogwqZL0EGBembgtzly
	Q6hn+7K71o+wddNtWjbiqVpJlQUhAQcphS8fg3UKGs7HCy/0LWEEN3k+1j
X-Google-Smtp-Source: AGHT+IHPxqEW49Ey0+zH+V6NlQOHGZMBbZmRTn/CRr7R/OqlH3S491uTZTrMlBZvDnudHLtpe1IUUQ==
X-Received: by 2002:a05:6402:3582:b0:639:fd12:65a2 with SMTP id 4fb4d7f45d1cf-63ed84965d2mr2330090a12.15.1761641686193;
        Tue, 28 Oct 2025 01:54:46 -0700 (PDT)
Received: from google.com (96.211.141.34.bc.googleusercontent.com. [34.141.211.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef96105sm8342279a12.19.2025.10.28.01.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:54:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 08:54:41 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, jmorris@namei.org,
	serge@hallyn.com, casey@schaufler-ca.com, kpsingh@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	john.johansen@canonical.com, eparis@redhat.com,
	audit@vger.kernel.org
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
Message-ID: <aQCE0WwGlOADI5xT@google.com>
References: <20251025001022.1707437-1-song@kernel.org>
 <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
 <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
 <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com>

On Mon, Oct 27, 2025 at 09:50:11PM -0400, Paul Moore wrote:
> On Mon, Oct 27, 2025 at 6:45 PM Song Liu <song@kernel.org> wrote:
> > On Mon, Oct 27, 2025 at 2:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Oct 24, 2025 at 8:10 PM Song Liu <song@kernel.org> wrote:
> > > >
> > > > lsm_prop_bpf is not used in any code. Remove it.
> > > >
> > > > Signed-off-by: Song Liu <song@kernel.org>
> > > >
> > > > ---
> > > >
> > > > Or did I miss any user of it?
> > > > ---
> > > >  include/linux/lsm/bpf.h  | 16 ----------------
> > > >  include/linux/security.h |  2 --
> > > >  2 files changed, 18 deletions(-)
> > > >  delete mode 100644 include/linux/lsm/bpf.h
> > >
> > > You probably didn't miss any direct reference to lsm_prop_bpf, but the
> > > data type you really should look for when deciding on this is
> > > lsm_prop.  There are a number of LSM hooks that operate on a lsm_prop
> > > struct instead of secid tokens, and without a lsm_prop_bpf
> > > struct/field in the lsm_prop struct a BPF LSM will be limited compared
> > > to other LSMs.  Perhaps that limitation is okay, but it is something
> >
> > I think audit is the only user of lsm_prop (via audit_names and
> > audit_context). For BPF based LSM or audit, I don't think we need
> > specific lsm_prop. If anything is needed, we can implement it with
> > task local storage or inode local storage.
> >
> > CC audit@ and Eric Paris for more comments on audit side.
> 
> You might not want to wait on a comment from Eric :)
> 
> > > that should be discussed; I see you've added KP to the To/CC line, I
> > > would want to see an ACK from him before I merge anything removing
> > > lsm_prop_bpf.
> >
> > Matt Bobrowski is the co-maintainer of BPF LSM. I think we are OK
> > with his Reviewed-by?
> 
> Good to know, I wasn't aware that Matt was also listed as a maintainer
> for the BPF LSM.  In that case as long as there is an ACK, not just a
> reviewed tag, I think that should be sufficient.

ACK.

> > > I haven't checked to see if the LSM hooks associated with a lsm_prop
> > > struct are currently allowed for a BPF LSM, but I would expect a patch
> > > removing the lsm_prop_bpf struct/field to also disable those LSM hooks
> > > for BPF LSM use.
> >
> > I don't think we need to disable anything here. When lsm_prop was
> > first introduced in [1], nothing was added to handle BPF.
> 
> If the BPF LSM isn't going to maintain any state in the lsm_prop
> struct, I'd rather see the associated LSM interfaces disabled from
> being used in a BPF LSM just so we don't run into odd expectations in
> the future.  Maybe they are already disabled, I haven't checked.

Well, it doesn't ATM, but nothing goes to say that this will change in
the future. Until then though, I have no objections around removing
lsm_prop_bpf from lsm_prop as there's currently no infrastructure in
place allowing a BPF LSM to properly harness lsm_prop/lsm_prop_bpf. By
harness, I mean literaly using lsm_prop/lsm_prop_bpf as some form of
context storage mechanism.

As for the disablement of the associated interfaces, I don't feel like
this warranted at this point? Doing so might break some out-of-tree
BPF LSM implementations, specifically those that might be using these
associated LSM interfaces purely for instrumentation purposes at this
point?
