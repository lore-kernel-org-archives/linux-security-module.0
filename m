Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0482F50;
	Thu, 13 Jun 2024 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314114; cv=none; b=RCsQLDccuYhpgRaxfSXAkG5P23ax1eRJJ8AYinXFnPTFk02eShjY2YjMn0okZJKb8Rbj7eZsw8eX+S9FJ3JHrd5O29gh5owEa84sr548ll9kve5RJ5dyxWAp4nJ8T5mvIw2E2ShNOHt7fgyoMA77ntLY0XFa7A5tgfRxhOFFMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314114; c=relaxed/simple;
	bh=lQRNKUS+iBpvuTMpf193ejGTFCkscE26dA7f7KxEze8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3bzXt8eLDYWVb8jNGY9u71elgHCKBcmj/RUHV+b9xYdQuYKgJBjLz48ea+0OnYgI0lO+GGlqHPYJI7BMxYvK/sFfF5ZYar/ZZeKf8dnXhvQuiBSc5bt+r0aTmDY0LWZIhJNMOZTWWD60A6VJl+45iTTOpnt1bXp8e/mCro0jgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B108AC2BBFC;
	Thu, 13 Jun 2024 21:28:32 +0000 (UTC)
Date: Thu, 13 Jun 2024 17:28:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] linux++: delete some forward declarations
Message-ID: <20240613172831.5e7f762f@rorschach.local.home>
In-Reply-To: <20240613142110.30019a4084d922d63c6d4352@linux-foundation.org>
References: <5ad5556c-7c32-45b7-89cf-f723c9d7332b@p183>
	<20240613153402.3b067d4b@rorschach.local.home>
	<20240613130420.a62ed8965a73b0f8d35890d4@linux-foundation.org>
	<20240613161012.1dd2ff60@rorschach.local.home>
	<20240613142110.30019a4084d922d63c6d4352@linux-foundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 14:21:10 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 13 Jun 2024 16:10:12 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > And...  I'm a bit surprised that forward declarations are allowed in C.
> > > A billion years ago I used a C compiler which would use 16 bits for
> > > an enum if the enumted values would fit in 16 bits.  And it would use 32
> > > bits otherwise.  So the enumerated values were *required* for the
> > > compiler to be able to figure out the sizeof.  But it was a billion
> > > years ago.  
> > 
> > Well, I only looked at the one change in ftrace.h which has a
> > "struct seq_file;" that is not used anywhere else in the file, so that
> > one definitely can go.  
> 
> The risk is that something which includes ftrace.h is depending upon
> the enum declaration.

You mean forward struct declaration. And if so, good! it needs to be fixed ;-)

-- Steve
