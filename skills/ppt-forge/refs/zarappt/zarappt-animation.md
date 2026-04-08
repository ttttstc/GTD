# ZaraPPT 动画模式

> 三大类动画系统：Entrance（进入动画）、Background（背景动效）、Interactive（交互反馈）

## 快速开始

动画通过 CSS class 触发，需要在 slide 中引入动画样式表：

```html
<style>
  /* 方式1: 使用预设动画类 */
  .anim-slide-in { animation: slideIn 0.5s ease-out forwards; }
  .anim-fade-in { animation: fadeIn 0.6s ease-out forwards; }

  /* 方式2: 使用 CSS 变量控制 */
  .custom-anim {
    animation-duration: var(--anim-duration, 0.5s);
    animation-easing: var(--anim-easing, ease-out);
  }
</style>
```

---

## 1. Entrance Animations（进入动画）

### 基础进入动画

```css
/* 滑入动画 */
@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateX(-100px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

/* 淡入动画 */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

/* 缩放动画 */
@keyframes scaleIn {
  from {
    opacity: 0;
    transform: scale(0.8);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

/* 上浮动画 */
@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(50px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
```

### 动画类速查

| 类名 | 效果 | 适用元素 |
|------|------|---------|
| `.anim-slide-in` | 从左滑入 | 标题、列表 |
| `.anim-slide-in-right` | 从右滑入 | 对比内容 |
| `.anim-fade-in` | 淡入 | 任何元素 |
| `.anim-scale-in` | 缩放淡入 | 卡片、图片 |
| `.anim-slide-up` | 上浮 | 段落、代码 |
| `.anim-bounce-in` | 弹跳 | 强调元素 |

### 延迟链式动画

```html
<div class="anim-slide-in" style="animation-delay: 0.1s">第一项</div>
<div class="anim-slide-in" style="animation-delay: 0.2s">第二项</div>
<div class="anim-slide-in" style="animation-delay: 0.3s">第三项</div>
```

---

## 2. Background Effects（背景动效）

### 渐变背景动画

```css
/* 渐变位移 */
@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

.anim-gradient-shift {
  background: linear-gradient(
    45deg,
    #7B2FFF,
    #00D4FF,
    #FF00FF,
    #7B2FFF
  );
  background-size: 400% 400%;
  animation: gradientShift 8s ease infinite;
}

/* 呼吸效果 */
@keyframes breathe {
  0%, 100% { opacity: 0.8; }
  50% { opacity: 1; }
}

.anim-breathe {
  animation: breathe 3s ease-in-out infinite;
}
```

### 粒子背景

```css
/* 简单粒子效果 */
@keyframes particleFloat {
  0%, 100% {
    transform: translateY(0) rotate(0deg);
    opacity: 0.8;
  }
  50% {
    transform: translateY(-20px) rotate(180deg);
    opacity: 0.4;
  }
}

.particle {
  position: absolute;
  width: 4px;
  height: 4px;
  background: rgba(123, 47, 255, 0.6);
  border-radius: 50%;
  animation: particleFloat 4s ease-in-out infinite;
}
```

---

## 3. Interactive Effects（交互反馈）

### Hover 效果

```css
/* 悬停放大 */
.anim-hover-zoom {
  transition: transform 0.3s ease;
}

.anim-hover-zoom:hover {
  transform: scale(1.05);
}

/* 悬停上浮 */
.anim-hover-lift {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.anim-hover-lift:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

/* 悬停变色 */
.anim-hover-color {
  transition: background-color 0.2s ease, color 0.2s ease;
}

.anim-hover-color:hover {
  background-color: #7B2FFF;
  color: white;
}
```

### 点击效果

```css
/* 点击反馈 */
.anim-click-scale {
  transition: transform 0.1s ease;
}

.anim-click-scale:active {
  transform: scale(0.95);
}

/* 点击涟漪 */
@keyframes ripple {
  to {
    transform: scale(4);
    opacity: 0;
  }
}

.ripple {
  position: relative;
  overflow: hidden;
}

.ripple::after {
  content: '';
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  pointer-events: none;
  background-image: radial-gradient(
    circle,
    rgba(255, 255, 255, 0.3) 10%,
    transparent 10%
  );
  background-repeat: no-repeat;
  background-position: 50%;
  transform: scale(0);
  opacity: 1;
}

.ripple:active::after {
  animation: ripple 0.6s ease-out;
}
```

### 键盘导航效果

```css
/* 当前 slide 指示器 */
.slide-indicator {
  transition: all 0.3s ease;
}

.slide-indicator.active {
  background: #7B2FFF;
  transform: scale(1.2);
}

/* 导航按钮聚焦 */
.nav-btn:focus {
  outline: 2px solid #00D4FF;
  outline-offset: 2px;
}
```

---

## 4. 组合动画

### 复杂入场序列

```css
/* 标题 + 内容组合 */
@keyframes complexEntrance {
  0% {
    opacity: 0;
    transform: translateY(30px);
  }
  60% {
    opacity: 1;
    transform: translateY(-10px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

.anim-complex {
  animation: complexEntrance 0.8s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}
```

### 交错动画

```html
<style>
  /* 使用 nth-child 交错 */
  .stagger-item:nth-child(1) { animation-delay: 0.1s; }
  .stagger-item:nth-child(2) { animation-delay: 0.2s; }
  .stagger-item:nth-child(3) { animation-delay: 0.3s; }
  .stagger-item:nth-child(4) { animation-delay: 0.4s; }
  .stagger-item:nth-child(5) { animation-delay: 0.5s; }
</style>

<ul class="stagger-list">
  <li class="stagger-item anim-slide-up">列表项 1</li>
  <li class="stagger-item anim-slide-up">列表项 2</li>
  <li class="stagger-item anim-slide-up">列表项 3</li>
</ul>
```

---

## 5. JavaScript 控制

### 动画触发

```javascript
// 方式1: 添加 class 触发动画
element.classList.add('anim-slide-in');

// 方式2: 使用 Intersection Observer
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('anim-fade-in');
    }
  });
}, { threshold: 0.1 });

// 方式3: 键盘/点击触发
document.addEventListener('keydown', (e) => {
  if (e.key === 'ArrowRight') {
    showNextSlide();
  }
});
```

### 动画控制类

```javascript
class AnimationController {
  constructor() {
    this.currentSlide = 0;
  }

  nextSlide() {
    const current = document.querySelector('.slide.active');
    const next = current.nextElementSibling;

    if (next && next.classList.contains('slide')) {
      current.classList.remove('active');
      next.classList.add('active');
      this.currentSlide++;
    }
  }

  prevSlide() {
    const current = document.querySelector('.slide.active');
    const prev = current.previousElementSibling;

    if (prev && prev.classList.contains('slide')) {
      current.classList.remove('active');
      prev.classList.add('active');
      this.currentSlide--;
    }
  }
}
```

---

## 6. 性能优化

### GPU 加速

```css
/* 使用 transform 和 opacity 进行动画 */
.anim-optimized {
  transform: translateZ(0); /* 强制 GPU */
  will-change: transform, opacity;
}

/* 避免触发布局的重排/重绘 */
.anim-performant {
  animation: fadeIn 0.5s ease;
  /* 避免: width, height, margin, padding */
}
```

### 减少动画

```css
/* 减少动画偏好 */
@media (prefers-reduced-motion: reduce) {
  .anim-slide-in,
  .anim-fade-in,
  .anim-scale-in {
    animation: none;
    opacity: 1;
    transform: none;
  }
}
```

---

## 7. 动画预设模板

### 快速复制模板

```html
<!-- 基础模板 -->
<div class="slide">
  <h1 class="anim-slide-in">标题</h1>
  <p class="anim-fade-in" style="animation-delay: 0.2s">内容</p>
  <div class="anim-scale-in" style="animation-delay: 0.4s">
    <img src="image.png" alt="图片">
  </div>
</div>

<style>
  .anim-slide-in {
    animation: slideIn 0.5s ease-out forwards;
    opacity: 0;
  }
  .anim-fade-in {
    animation: fadeIn 0.6s ease-out forwards;
    opacity: 0;
  }
  .anim-scale-in {
    animation: scaleIn 0.5s ease-out forwards;
    opacity: 0;
  }
</style>
```
