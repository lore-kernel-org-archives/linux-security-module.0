From: paul@paul-moore.com (Paul Moore)
Date: Wed, 31 May 2017 10:22:12 -0400
Subject: namespaces todo list?
In-Reply-To: <82271f8b-c366-28b1-90ac-3b0780490fa5@poczta.onet.pl>
References: <82271f8b-c366-28b1-90ac-3b0780490fa5@poczta.onet.pl>
Message-ID: <CAHC9VhRVD03P3_5m2aekUibJMJNj17wCYRO5=dJ1Ctou13eu8w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 31, 2017 at 8:45 AM, Micha? Zegan
<webczat_200@poczta.onet.pl> wrote:
> Hello.
>
> Trying to track progress with linux containers, however I am quite lost.
> So, what is left to be done? I mean namespace security holes, things you
> cannot do but should be able to, etc.
> I know about those:

...

> 2 - autofs, audit, whatever...?

Proper support for namespaces/containers is a high priority item for
those of us working in the audit space, if you are interested I would
suggest joining the linux-audit mailing list (CC'd).

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
