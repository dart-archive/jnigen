#pragma once

#if defined _WIN32
#include <windows.h>

typedef CRITICAL_SECTION MutexLock;

static inline void _initLock(MutexLock* lock) {
  InitializeCriticalSection(lock);
}

static inline void _acquireLock(MutexLock* lock) {
  EnterCriticalSection(lock);
}

static inline void _releaseLock(MutexLock* lock) {
  LeaveCriticalSection(lock);
}

static inline void _destroyLock(MutexLock* lock) {
  DeleteCriticalSection(lock);
}

#elif defined __DARWIN__ || defined __LINUX__ || defined __ANDROID__ ||        \
    defined __GNUC__
#include <pthread.h>

typedef pthread_mutex_t MutexLock;

static inline void _initLock(MutexLock* lock) {
  pthread_mutex_init(lock, NULL);
}

static inline void _acquireLock(MutexLock* lock) {
  pthread_mutex_lock(lock);
}

static inline void _releaseLock(MutexLock* lock) {
  pthread_mutex_unlock(lock);
}

static inline void _destroyLock(MutexLock* lock) {
  pthread_mutex_destroy(lock);
}

#else

#error "No locking support; Possibly unsupported platform"

#endif

typedef struct JniLocks {
  MutexLock classLoadingLock;
  MutexLock methodLoadingLock;
  MutexLock fieldLoadingLock;
} JniLocks;

/// To be defined by generated code, for the time being.
extern JniLocks locks;
