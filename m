Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831E5F876;
	Thu, 13 Jun 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313672; cv=none; b=FZL6fhY9X359gkF+molAa+cOtlZ/uRGy0Qt9o9R6KdRovz9nlCN+P9sEfc/unItDjO1sLJFI2P+uNPklf4JS56ByOLS/r7nPZzZj+hYmkEbb+i9JHofkl44D+7RdEcrrdVx8Lz4GdLMOSN0wn18iyO8CCtJ8oP+wlVWdMxVZ6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313672; c=relaxed/simple;
	bh=tIVI8sDxoP6vcgbRqp/b+XMQGtqvU/991pldqPDDpVo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S2fBkhXplaQKklbXGnoKHDySZG/yts+uYJOlbJBuIiNIW04Q2y+9L2moBKzi07Rk6zBkKwICtEB+6hMTIFBLWiQuIAruEHr3J9JVgv+EeTVDEUSdCEQeSZmNoOrEp1mRRq5c8E5kNPo1KDqZNubtdqvjm9ithljRU2fvrzDxJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ufbtqggP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ufbtqggP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA7BC2BBFC;
	Thu, 13 Jun 2024 21:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718313671;
	bh=tIVI8sDxoP6vcgbRqp/b+XMQGtqvU/991pldqPDDpVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ufbtqggP0qaJWrdyuqK5JCm+amuWgHEKBTQAJvq5bYk1bRoaLGybAa033rBWFP5EC
	 UlzfQnjdB/G2RD3fX9gn+0HedIfldL8bmA0C28PVro8Jbtc5B6gef5OYfZeGFDay6Y
	 mlvkoxIoQt0gOnqRVafCCcl8uX0yOtsDDIlEeP7Q=
Date: Thu, 13 Jun 2024 14:21:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] linux++: delete some forward declarations
Message-Id: <20240613142110.30019a4084d922d63c6d4352@linux-foundation.org>
In-Reply-To: <20240613161012.1dd2ff60@rorschach.local.home>
References: <5ad5556c-7c32-45b7-89cf-f723c9d7332b@p183>
	<20240613153402.3b067d4b@rorschach.local.home>
	<20240613130420.a62ed8965a73b0f8d35890d4@linux-foundation.org>
	<20240613161012.1dd2ff60@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 16:10:12 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

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

The risk is that something which includes ftrace.h is depending upon
the enum declaration.
