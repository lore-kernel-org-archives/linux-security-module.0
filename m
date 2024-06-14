Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651BE1EEE0;
	Fri, 14 Jun 2024 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346579; cv=none; b=oz/X5nvp7K+S5s86WSlT6zmIh/3zWWjMo+PLR+IgjTcUfuBzS5V9S4fh2lGw6DoKsmib472UefnWRXHc7TQBKLngDNwnpN3SrRCLOXoz2uaTjE/ucNEIMGdEtfEXoWs2pSc4wg4QiV75AZ4i8qlGdAz1ULFlOQG325A7cMPKSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346579; c=relaxed/simple;
	bh=SWv5Y3/Unba0KZDE/AlTebpmpXShx8eRF1ru3+9BvJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSliV7af/0yhioF150qdrXM1iKCecG2tAHbxeWQZqswD9hwQUOyMHHs/24eadFsLbdtyjlWEsRx31F5HMekPxxmNAdq8l2uRIcxCqildnk6yqMA4f7szOK8EQyTE/qDiYGoDyoh/w6garPgUAESAi8exFH2VBRRIYR55LzAsG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxacswBI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxacswBI"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f236a563cso1547229f8f.2;
        Thu, 13 Jun 2024 23:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718346576; x=1718951376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pn3XIo1FDmmSG/nyq3G2IvjJub61mr4heaF3EjMELcs=;
        b=RxacswBIvmfmS7e0bPHrd8VFmnZT3kwalre4IQNQn1hkrbbNMKeCW7nxXw9O1rTLQU
         dZfS5/BVrMY0fBioQ50lfhZD77opcxvlIL+lrxZmzuzsd1oU1VvglWh15x0lm0J4n9eg
         W6zhK0z3CofcEAsRqhiVCFLUzZUFu0AZ6lQ5CW3VSOcdy2g6TiGWGnKCTtk/Y1aPdCZw
         whTv2+a+VGkgjmVR0qEj+exEQBGeDL61tI2wOYRyr87+yttYMRiM1R4xwxsATwyxo4i+
         zY5+yeyD10t3MzgkgIqBRQfUx1BLYMX/gia//hzGyQCQuIzK3E/p3vvPdXP8jgnDhm91
         uASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718346576; x=1718951376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pn3XIo1FDmmSG/nyq3G2IvjJub61mr4heaF3EjMELcs=;
        b=eMqImiIKyALigto9kBmfR7Y06QW288vgH3HHtXo1BrWTmNsPaurBEPEhjkeGCXj6W8
         SHXOyzPAVJaVi+uVUEdgvEw/yqVz+6ePef+hY0INY0D2xwVpgI3B/cpDSC14eMbkHKC3
         nnvUyIuP6xk78l9fZpFYxSNdeIQRn3MBZrijRckYz9c47SRqEBbPa+5qzLbq5zNixetP
         BVJEB+UTeivHTu50webpyC0q4fevstMPkZjJbGXTKJGZS00pRSy17Rd7QZUK5hqmYL7X
         t4/5x5sS8mzu3a4pj6oJOi0mBjSjVzNkO7WmlhTe2GVSRfuHguDkbVxR0aaatuH1CiHt
         8/ng==
X-Forwarded-Encrypted: i=1; AJvYcCV5fDu13r78/u+DHGaA+8nLeWs+tOhKfTYmGRPiV5g6oDmoV7uva+rfZ7l7lXMCyIuMHjR2Dq0PRhZd6kAo/9vQ13JV2Uz+f5NlD0gpY0biRPK81/jcXWIRJ6CqGercxKROAE3wkU6Ry1WWN+cYUEK1k6IvnzpY3V0n3w8vWYfepiJ6O3ljeo4oa3X2nIKXsPIYlR/Wdj7A
X-Gm-Message-State: AOJu0YyP07gNjLV1toDBgyoDUj5DgL0aClr6uQpmPvU13UD6eln0zJCn
	5ITuKwLfRe9CKXyQg2zkEMpGdjRwCWZhqM9y0uCpt/sJAbVyBqs=
X-Google-Smtp-Source: AGHT+IG8Z2kEHMwew0brh1MHGINbTrdni8vxAnQtTIKV5S9wlZUJGOv8+54ZNV5mmL6RR9yKHmRHqA==
X-Received: by 2002:a05:6000:1289:b0:35f:1c6b:2b24 with SMTP id ffacd0b85a97d-3607a7610bemr1180861f8f.29.1718346575485;
        Thu, 13 Jun 2024 23:29:35 -0700 (PDT)
Received: from p183 ([46.53.250.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509355dsm3449841f8f.13.2024.06.13.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 23:29:34 -0700 (PDT)
Date: Fri, 14 Jun 2024 09:29:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] linux++: delete some forward declarations
Message-ID: <3efb99f7-ddef-4958-9c83-4e1009b1a914@p183>
References: <5ad5556c-7c32-45b7-89cf-f723c9d7332b@p183>
 <20240613153402.3b067d4b@rorschach.local.home>
 <20240613130420.a62ed8965a73b0f8d35890d4@linux-foundation.org>
 <20240613161012.1dd2ff60@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613161012.1dd2ff60@rorschach.local.home>

On Thu, Jun 13, 2024 at 04:10:12PM -0400, Steven Rostedt wrote:
> On Thu, 13 Jun 2024 13:04:20 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Thu, 13 Jun 2024 15:34:02 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Thu, 13 Jun 2024 22:22:18 +0300
> > > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >   
> > > > g++ doesn't like forward enum declarations:
> > > > 
> > > > 	error: use of enum ‘E’ without previous declaration
> > > > 	   64 | enum E;  
> > > 
> > > But we don't care about g++. Do we?  
> > 
> > It appears that g++ is a useful enum declaration detector.
> > 
> > I'm curious to know how even the above warning was generated.  Does g++
> > work at all on Linux?

With out-of-tree patch, yes.

What happens is that "enum E;" works in C but doesn't work in C++.
The fix (in C++) is to either delete, or change to "enum E:int;".

The same applies to

	const struct S s;
	const struct S s = {};

First declaration is compile error in C++, sometimes it can be deleted.

This patch is some "unused" parts merged together because it doesn't
make sense to split this much -- every chunk is independent of each
other.

> > > I would make that a separate patch.  
> > 
> > What are you referring to here?
> 
> The enum change should be separate from the struct changes.
> 
> > 
> > > > 
> > > > Delete those which aren't used.
> > > > 
> > > > Delete some unused/unnecessary forward struct declarations for a change.  
> > > 
> > > This is a clean up, but should have a better change log. Just something
> > > simple like:
> > > 
> > >   Delete unnecessary forward struct declarations.  
> > 
> > Alexey specializes in cute changelogs.
> 
> eh

Steven is right. That's what my literature teacher said in high school.

> > I do have a concern about the patch: has it been tested with all
> > possible Kconfigs?  No.  There may be some configs in which the forward
> > declaration is required.
> > 
> > And...  I'm a bit surprised that forward declarations are allowed in C.
> > A billion years ago I used a C compiler which would use 16 bits for
> > an enum if the enumted values would fit in 16 bits.  And it would use 32
> > bits otherwise.  So the enumerated values were *required* for the
> > compiler to be able to figure out the sizeof.  But it was a billion
> > years ago.
> 
> Well, I only looked at the one change in ftrace.h which has a
> "struct seq_file;" that is not used anywhere else in the file, so that
> one definitely can go.

It was tested on arm64 allmodconfig too.

OK if this is concern, I could dust off my compile test farm.
