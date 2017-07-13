From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 12 Jul 2017 19:33:16 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <alpine.LRH.2.20.1707130820050.16810@namei.org> (James Morris's
	message of "Thu, 13 Jul 2017 08:20:34 +1000 (AEST)")
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com> <20170712170346.GA17974@mail.hallyn.com>
	<alpine.LRH.2.20.1707130820050.16810@namei.org>
Message-ID: <87o9spfa5v.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris <jmorris@namei.org> writes:

> On Wed, 12 Jul 2017, Serge E. Hallyn wrote:
>
>> Quoting Eric W. Biederman (ebiederm at xmission.com):
>> > Stefan Berger <"Stefan Bergerstefanb"@linux.vnet.ibm.com> writes:
>> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> > > Signed-off-by: Serge Hallyn <serge@hallyn.com>
>> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
>> > 
>> > It doesn't look like this is coming through Serge so I don't see how
>> > the Signed-off-by tag is legtimate.
>> 
>> This is mostly explained by the fact that there have been a *lot* of
>> changes, many of them discussed in private emails.
>
> Please try and keep technical discussions public or at least document them 
> when reposting the patches.

Yes please.

A public discussion helps to understand what the challenges are.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
