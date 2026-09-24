Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22B38910F
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266517; cv=none; b=Xg3Jy243+bBDfx8YBdAHUGexlb4rdjDZCe+4Jf5dFmfpeBs8D/0tEBQ81VN7Qc2+KUfXLfUs4MUPojz6ukcpDRd+luZfEiyl5Q1tol7DHzJTsR172ZeQurHQOhmdS8KaDpJObagEidzSqDuXyh/8Zj14Ujj6otzAkDhhkKeXNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266517; c=relaxed/simple;
	bh=Skw07uGHtEgXiU/xEUK5orE3/dgl0NDLHVhoeRjk+0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4njAJXgb2RplvKErqFnWtfS2gmaYmVezKm+zIAvnKUkmgrm6cegj035YHrLW4uTxu69mmVTD2LBWFxBV1/Sey2a4yQbdHDMRC6E4LZJGV9Y0plLiZco4V3TPr+zJKNt5BNfJlKWxL9eVHQ5H+d5+qfTbsvvBAZVJroWA4i910g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8wDDPjK; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8wDDPjK"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f516c271so72182d50.2
        for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266514; x=1790871314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CPLSKu+wpmxnT92rDqRdMDJHK7EmdoObLiAfE0URKFU=;
        b=H8wDDPjKW+5BtbrsBAuvhfCmRTctNGUFflpPNTEB9la1Vs8e69/BPJ07xgAMNN7RSi
         J63ey8U69plPEvR+vqcMxH10QrSb73em8Fog+876Df6rrpwTvjW3n7F9w18s494OOQaB
         6FfDhPCNTRFEeHwDo37PPQ48SanRxvHHwBMiUmiQWh31rGdEtqn3FvsRiZrdU/6py/9p
         CApVKYsOtSmS68r8z92Beiq/QlrSNJ1GZq8I0eZEUGyl0qHhPW04J66eJkxXiwaF7RH5
         VwqERZGWa6TcKndFZMo2D7AvDAMwYX8B+xO4ui/EbvStPBBC+LTM3R1IjG6yhwl5ngHF
         rjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266514; x=1790871314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CPLSKu+wpmxnT92rDqRdMDJHK7EmdoObLiAfE0URKFU=;
        b=GSitHvuoqjv1kv3mLHZuLIPxN2GXJAU4zCt3VKRS8QKA4Xvaa1W582BGQWVU9C1EFH
         ZSuFLgvxjCHrk75gB0wa2XnCJsW3Sa+lIeixsWpdLSxwh8n4SaHSF62xq/9kWINgRDQA
         boG+ydLEYtFT0XRrbL8KLc1ghOmzOSThxjgWIZYCBO9LYy6IV0xk1SeooA859opoj43Z
         KQBdR4hZ7QTLmS9kA5YprAdew7DeOpRfAu+vAYGhkb9H8jKa+ng5SmIG/Qu0iEz6FUmd
         2MgUZDZ40AdRWeAiwZRF1WSwbF/qMBYYp6eGWwjA1nwVmfZ8Yqy3DrT1ZD6iakv4QbI0
         DdOg==
X-Forwarded-Encrypted: i=1; AKwUvBzcKijQ2t6SKSxhhw97JYkEfPXKTWqCzfGWNwd6EwtLCT9GxtQpPHj+jfvsKPjEkjOXFPdG0dheMPu6b7/WuS09GSjStK0=@vger.kernel.org
X-Gm-Message-State: AFuF++ldnRsHaY4vI6/I/wdikXlj3jvosz+wNRQCGMGbnRzA7sQ1ew+I
	GKnb3KbaVRT7+YrVrhanydDLLkCoaq5QFH3PYbv0ty5G3MKhgNiwqHOW
X-Gm-Gg: AYBFou1aau1N3Enl/+SowVGmKTfcw7x8E65p95YNhxZmbeW3MnLJSzs0neel0mtDuVW
	h86AE0MqlpN83wAbzT/OylgsYCZFdfvJ/q1XMSKxuAa+9yVXLqumLKCRIfppKhfaUXxIo4SE8rq
	KmK2SPxv8m7/qknNvNd/2ZoDWyq8hNHCPSuw+ScLsgYLMN/mKc3n4Lsphd0Z4iuF7dJML//JVGr
	9M/NTl491Tpc+hrapqN3asfgK4Sqmq/BJSDFD6UkP4EBM2YiN9E3GbPd8C31M7K6Z34OHiyBE0j
	9ZZW1oT3+OoAS3nAiyFq0hCn8lkeBA7sEuIyy2HNgjvkEANNSv6NcNK92+fVbK7VtIWWAAcREKa
	9mPD4rMUpdO7/FjKHrZ86nfLT9sXizs6/Ur5VitThOkZLZS1CinJO8C7InSq/s4kGo9yVvfHmrk
	XJBzPkW5UZFyWFNyudbJJI3sJm70Ag5H4PlJC0Iv4STdmDwtEeGYlXajgZK00pJPuXK+sNp/Znu
	LA=
X-Received: by 2002:a05:690e:e81:b0:673:697a:d527 with SMTP id 956f58d0204a3-673697aded5mr986003d50.35.1790266514390;
        Thu, 24 Sep 2026 09:15:14 -0700 (PDT)
Received: from suesslenovo ([71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672e0f3be58sm1732948d50.11.2026.09.24.09.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:15:13 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:14:42 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: David Windsor <dwindsor@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
Message-ID: <arVKSpezisxe3pkr@suesslenovo>
References: <20260915150739.284189-1-daniel@iogearbox.net>
 <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
 <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>

On Wed, Sep 23, 2026 at 03:14:28PM -0400, David Windsor wrote:
> On Wed, Sep 23, 2026 at 12:57 PM Paul Moore <paul@paul-moore.com> wrote:
> > @David, simply for my own understanding, did you ask Daniel to do
> > this, or was Daniel operating on his own with this patchset?
> >
> 
> Daniel and I work together and both have things written on top of this
> kfunc. He reached out to collaborate, I agreed. We're also going to
> send bpf_set_file_xattr shortly.
> 
> This implementation was chosen due to its immediate mergeability (it
> only touches security/bpf), but was actually suggested by Kumar in v1
> or so of my original series.
> 
> That said, sorry for any confusion about this appearing as a new
> series rather than as v7 of my previous one.
>
Howdy all,

Hope you all are doing well and having a good Thursday.

These patches are excellent and useful, and have been in the pipeline
for a while. 

In the interest of moving forward:

Would you both be able to live with the following: provide a security hook
for lsm_get_xattr_slot or another proper interface with the necessary
abstraction, and keep the kfunc where it is in fs/?

This addresses the primary concern about calling into LSM internals by
providing a blessed interface. I'd be happy to detail what I had in mind.

I think the end users care extremely little about what directory the
source code ends up in. They care about: getting useful features.

We all work in the same kernel and it's easier to walk when both legs
are going in the same direction. I think that this hill would be an
unfitting, uninteresting place for these useful patches to die on :) 

Let me know if this is something you both could stomach.

Sincerely,
Justin
