Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC0E28466F
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765819263; cv=none; b=iGKt8rNx7O38TvthypRn423HV4ovx8k1CZeCMQvmkOdGQSjnnqpWPl+tCNxzblnnmGg/zzx1T67mACfgA7R1eI+ezvplCR0pT7EycNuMcmJLQR8Wsxv2eYYLJ2T6m65NydqCrpLnBtXZqceogsK4Od8pG+AxBBkmb5323FgytuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765819263; c=relaxed/simple;
	bh=2D1E8cnZ2EHY1RUVdG07pimBEVIvWUt5lrRmjG50N40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCCfgQt5hlvEbS/Gz5nPs4XrIeQQQGa68mF+ZTmCKFa9zUXS2zQmCNw/zufyv0G+hZXBGjUmHmqWp3NPyYNnkT9Ztgx/huNiGjh2oxF73VovfkH+sjhYrC8EqwT4A+aGmWPYpTaWQqkDJrmRozIOiaba+4z09GP+hGwSmOs0K60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 5BFGvKec012547;
	Mon, 15 Dec 2025 10:57:20 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 5BFGvHgD012546;
	Mon, 15 Dec 2025 10:57:17 -0600
Date: Mon, 15 Dec 2025 10:57:17 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, corbet@lwn.net
Subject: Re: A formal request for process clarifications.
Message-ID: <20251215165717.GA12485@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20251215070838.GA7209@wind.enjellic.com> <CAHk-=whqzs-3u6Y7UC03A_XJEy6H1kNWvFO_A8jqsuob7SZCLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whqzs-3u6Y7UC03A_XJEy6H1kNWvFO_A8jqsuob7SZCLA@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 15 Dec 2025 10:57:20 -0600 (CST)

On Mon, Dec 15, 2025 at 07:38:58PM +1200, Linus Torvalds wrote:

Good morning Linus, thanks for taking the time to respond.

> On Mon, 15 Dec 2025 at 19:13, Dr. Greg <greg@enjellic.com> wrote:
> >
> > Three years ago our team had submitted for review our TSEM LSM that
> > provides a framework for generic security modeling,

> If you can't convince the LSM people to take your code, you sure can't
> convince me.
> 
> I already think we have too many of those pointless things. There's a
> fine line between diversity and "too much confusion because everybody
> thinks they know best". And the linux security modules passed that
> line years ago.
> 
> So my suggestion is to standardize on normal existing security models
> instead of thinking that you can do better by making yet another one.
> Or at least work with the existing people instead of trying to bypass
> them and ignoring what they tell you.
> 
> Yes, I know that security people always think they know best, and they
> all disagree with each other, which is why we already have tons of
> security modules.  Ask ten people what model is the right one, and you
> get fifteen different answers.
> 
> I'm not in the least interested in becoming some kind of arbiter or
> voice of sanity in this.

First, to be very clear, we are not asking for any kind of
intervention or arbitration on your part.

Second and most importantly.  You've been belly-aching about this
problem for as long as I can remember and you I go back to 1992
together with Linux.

You, and only you, can fix the problem if you want it fixed.  Issue an
immediate statement that you will no longer accept any code that
implements an 'LSM'.

That will drive security development out of the kernel, which is where
it is going to go eventually anyway OR it will drive the security
community to try and fix what it considers to be the challenges with
eBPF when it comes to building security solutions.

Somewhat paradoxically in all of this, TSEM isn't even an LSM that
implements security policy.  It is generic infrastructure that was
built to address the very problem you are bitching about.

If Linux is really about technology, as you have continually
advocated, then there has to be an open playing field for
contributors.  Absent that, Linux will balkanize, the same way the
commercial Unix implementations did, around corporate driven
interests and motivations.

We will pursue the open playing field issue through the TAB if
necessary.


>               Linus

Once again, with all due respect, fix the problem if it annoys you,
you would be doing a lot of people a favor.

Best wishes for a pleasant holiday season to you and your family.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
