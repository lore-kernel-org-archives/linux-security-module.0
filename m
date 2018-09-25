From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 25 Sep 2018 11:41:47 +0200
Subject: [GIT PULL] Keys: fix C++ reserved word issue
In-Reply-To: <alpine.LRH.2.21.1809250738020.27047@namei.org>
References: <alpine.LRH.2.21.1809250738020.27047@namei.org>
Message-ID: <20180925094147.GC21972@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 25, 2018 at 07:40:06AM +1000, James Morris wrote:
> Please pull this revert and update, from David Howells:
> 
> "Here's a pair of fixes that need to go upstream asap, please:
> 
>  (1) Revert an incorrect fix to the keyrings UAPI for a C++ reserved word
>      used as a struct member name.  This change being reverted breaks
>      existing userspace code and is thus incorrect.
> 
>      Further, *neither* name is consistent with the one in the keyutils
>      package public header.
> 
>  (2) Fix the problem by using a union to make the name from keyutils
>      available in parallel and make the 'private' name unavailable in C++
>      with cpp-conditionals."
> 
> ---
> The following changes since commit 02214bfc89c71bcc5167f653994cfa5c57f10ff1:
> 
>   Merge tag 'media/v4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-09-24 15:16:41 +0200)

{sigh}

$ date --date="2018-09-25 07:40:06 +1000" +%s
1537825206
$ date --date="2018-09-24 15:16:41 +0200" +%s
1537795001
$ bc <<< "1537825206-1537795001"
30205
$ date -ud "@30205" +'%H hours %M minutes %S seconds'
08 hours 23 minutes 25 seconds

8.5 hours seems like a short amount of time for something to sit in a
tree before asking for it to be merged.  Wait, it's actually less than
that, I just took into account the longest possible time it could have
been in your tree.

I'll wait a few days on this one...

thanks,

greg k-h
