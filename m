From: paul@paul-moore.com (Paul Moore)
Date: Mon, 14 May 2018 15:39:04 -0400
Subject: [PATCH v2 1/3] selinux: add AF_UNSPEC and INADDR_ANY checks to
	selinux_socket_bind()
In-Reply-To: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526058913-14198-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <CAHC9VhTk8YEwG8kaApH9so67uZOhv=6kKpPVbpwxUju8t9B-AA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 11, 2018 at 1:15 PM, Alexey Kodanev
<alexey.kodanev@oracle.com> wrote:
> Commit d452930fd3b9 ("selinux: Add SCTP support") breaks compatibility
> with the old programs that can pass sockaddr_in structure with AF_UNSPEC
> and INADDR_ANY to bind(). As a result, bind() returns EAFNOSUPPORT error.
> This was found with LTP/asapi_01 test.
>
> Similar to commit 29c486df6a20 ("net: ipv4: relax AF_INET check in
> bind()"), which relaxed AF_INET check for compatibility, add AF_UNSPEC
> case to AF_INET and make sure that the address is INADDR_ANY.
>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>
> v2: As suggested by Paul:
>     * return EINVAL for SCTP socket if sa_family is AF_UNSPEC and
>       address is not INADDR_ANY
>     * add new 'sa_family' variable so that it equals either AF_INET
>       or AF_INET6. Besides, it it will be used in the next patch that
>       fixes audit record.
>
>  security/selinux/hooks.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)

All three patches looked good to me.  I've merged them into
selinux/stable-4.17 and assuming nothing breaks in the next day or two
I'll send it up to Linus mid-week.

Thanks everyone!

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
