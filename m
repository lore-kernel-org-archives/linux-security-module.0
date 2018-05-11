From: jannh@google.com (Jann Horn)
Date: Fri, 11 May 2018 15:58:39 +0200
Subject: [PATCH v5 7/7] proc: add option to mount only a pids subset
In-Reply-To: <20180511093707.GA1403@comp-core-i7-2640m-0182e6>
References: <20180511093707.GA1403@comp-core-i7-2640m-0182e6>
Message-ID: <CAG48ez0bXvp1iF=HqyhEP1p5B6PRR07_j0qRoypJqs8x3Z+=mw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 11, 2018 at 11:37 AM, Alexey Gladkov
<gladkov.alexey@gmail.com> wrote:
> This allows to hide all files and directories in the procfs that are not
> related to tasks.

/proc/$pid/net and /proc/$pid/task/$tid/net aren't in scope for this
protection, even though they contain information about the whole
network namespace of the task, right?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
