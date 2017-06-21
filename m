From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 20 Jun 2017 17:41:42 -0700
Subject: The secmark "one user" policy
Message-ID: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I'm looking at the secmark code and am looking in
particular at the places where it explicitly says
that it is intended for one security module at a
time. For extreme stacking I can either enforce this
restriction by configuration or remove it by clever
uses of secid mappings. Either can be made "transparent"
to existing user-space. Paul has expressed distaste for
using configuration as a shortcut for dealing with this
kind of problem, and I generally agree with him. On the
other hand, the code is quite clear that it is designed
for one and only one kind of secid at a time. I don't
want to put a lot of effort into patches that are
unacceptable to the author.

Thank you.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
