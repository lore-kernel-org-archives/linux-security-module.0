From: paul@paul-moore.com (Paul Moore)
Date: Mon, 14 May 2018 17:51:31 -0400
Subject: [PATCH ghak81 RFC V2 4/5] audit: use inline function to set audit
	context
In-Reply-To: <567735cef55507a38120e30bea178980bb146313.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com>
	<567735cef55507a38120e30bea178980bb146313.1526173613.git.rgb@redhat.com>
Message-ID: <CAHC9VhT+9xV-EdChmB4b7pFtNWz2BrEsqWEzqfNSdKg8yj08Jg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, May 12, 2018 at 9:58 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Recognizing that the audit context is an internal audit value, use an
> access function to set the audit context pointer for the task
> rather than reaching directly into the task struct to set it.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h | 6 ++++++
>  kernel/auditsc.c      | 7 +++----
>  kernel/fork.c         | 2 +-
>  3 files changed, 10 insertions(+), 5 deletions(-)

Merged with some minor fuzz.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
