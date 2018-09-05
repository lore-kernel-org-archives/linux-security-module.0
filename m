From: igor.stoppa@gmail.com (Igor Stoppa)
Date: Thu, 6 Sep 2018 01:49:20 +0300
Subject: [PATCH] seccomp: remove unnecessary unlikely()
In-Reply-To: <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
	<CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
Message-ID: <2192189d-b8bb-3233-c9f3-14cbeeddaf34@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 06/09/18 01:23, Kees Cook wrote:

> Should I take this, or is it part of your series going somewhere else?

It turned out it doesn't really work to have a generic series against 20 
trees :-/

I'm submitting them individually to each subsystem.
So this one is just for security.

--
thanks, igor
