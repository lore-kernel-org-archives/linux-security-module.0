From: baolin.wang@linaro.org (Baolin Wang)
Date: Fri, 15 Sep 2017 16:38:35 +0800
Subject: [PATCH 0/3] Fix y2038 issues for security/keys subsystem
In-Reply-To: <CAMz4kuL-mriUk3YV6Mz9xgC7geNe5a05vhjfXaxt58x=7BUo0w@mail.gmail.com>
References: <cover.1502246501.git.baolin.wang@linaro.org>
	<4455.1502267323@warthog.procyon.org.uk>
	<CAMz4kuL-mriUk3YV6Mz9xgC7geNe5a05vhjfXaxt58x=7BUo0w@mail.gmail.com>
Message-ID: <CAMz4kuLKrwR3M=RX+SOX0k=MxxD9YMJF9YpGDpwZuC=M4zR_kw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

On 21 August 2017 at 20:12, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi David and James,
>
> On 9 August 2017 at 16:28, David Howells <dhowells@redhat.com> wrote:
>> The rxrpc patch isn't part of the security/keys subsystem.  I'll push it
>> to the network tree.  The other two I'll push to James.
>
> Could you apply this patch serials if there are no other comments? Thanks.

Could you apply patch1 and patch2? I have seen patch3 was merged into
4.14 by David. Thanks.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
